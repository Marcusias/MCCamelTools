//
//  ViewController.m
//  MCCamleTools
//
//  Created by Marcus on 16/5/31.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import "ViewController.h"
#import "MCContentVC.h"
#import "MCHTTPRequest.h"
#import "Fence.h"
#import "MCData.h"
@interface ViewController ()<NSTextFieldDelegate,NSAlertDelegate>
{
    NSMutableArray *_allFenceArray;
    NSMutableArray *_trigerFenceArray;
    NSMutableArray *tableData;
    NSMutableArray *_createdFenceArray;
}
@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    _allFenceArray = [NSMutableArray array];
    _trigerFenceArray = [NSMutableArray array];
    tableData = [NSMutableArray array];
    [[NSApplication sharedApplication].mainWindow center];
   // NSImageView *imageView = [[NSImageView alloc]initWithFrame:self.view.bounds];
    //[imageView setImage:[NSImage imageNamed:@"mainPic.jpg"]];
    ///[self.view];
    //[self.view addSubview:imageView];
    

}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)checkButtonClick:(NSButton *)sender
{
    if (_waybillNumberTextField.stringValue.length < 14)
    {
        [self showErrorMessageWithTitle:@"错误提示" content:@"运单号有误请重新输入"];
        
        NSLog(@"运单号不合法");
    }
    else
    {
        _allFenceArray = [NSMutableArray array];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if(sender.tag == 10010)
        {
            ///测试环境
            [userDefaults setObject:@"119080" forKey:@"serviceID"];
            [userDefaults setObject:@"http://139.129.201.205:5009/v1/log" forKey:@"port"];
        }
        else if(sender.tag == 10011)
        {
            ///运营环境
            [userDefaults setObject:@"113188" forKey:@"serviceID"];
            [userDefaults setObject:@"http://115.28.79.197:5008/v1/log" forKey:@"port"];
        }
        else
        {
            [userDefaults setObject:@"123202" forKey:@"serviceID"];
            [userDefaults setObject:@"http://139.129.201.205:5011/v1/log" forKey:@"port"];
        }
        
        [MCHTTPRequest getBaiduFenceListWithWaybillNumber:_waybillNumberTextField.stringValue success:^(NSArray *array)
         {
             NSMutableArray *usefulArray = [NSMutableArray array];
             for (NSDictionary *dict in array)
             {
                 Fence *fence = [[Fence alloc]initWithDictionary:dict];
                 
                 [usefulArray addObject:fence];
             }
             _allFenceArray = usefulArray;
             _createdFenceArray = [NSMutableArray array];
             
             for (Fence *fence in usefulArray)
             {
                 
                     NSMutableDictionary *dics=[[NSMutableDictionary alloc] init];
                     [dics setObject:fence.fenceName forKey:@"1"];
                     [dics setObject:fence.fenceID forKey:@"2"];
                     [dics setObject:fence.fenceRadius forKey:@"3"];
                     [dics setObject:fence.monitoredPersons forKey:@"4"];
                     [dics setObject:fence.fenceCenter forKey:@"5"];
                 
                     [_createdFenceArray addObject:dics];
             }
             NSLog(@"当前运单对应围栏 _____allfence%@",_allFenceArray);
            
             _trigerFenceArray = [NSMutableArray array];
             [self querryFenceTigerWithArray:usefulArray];
             
             NSLog(@"~~~~~~usefulFenceArray%@",_trigerFenceArray);
         }
        failure:^(NSString *error) {
                                                      }];
    }
}
- (void)showErrorMessageWithTitle:(NSString *)title content:(NSString *)content
{
    NSAlert *alert = [[NSAlert alloc] init];
    
    [alert addButtonWithTitle:@"我错了"];
    [alert setMessageText:title];
    [alert setInformativeText:content];
    [alert beginSheetModalForWindow:self.view.window completionHandler:^(NSModalResponse returnCode) {
    }];
    
}

- (NSMutableArray *)doHttp
{
       return _allFenceArray;
}



- (void)getTableDataWithArray:(NSArray *)array
{
    
    tableData=[[NSMutableArray alloc] init];
    NSMutableArray *tableData2=[[NSMutableArray alloc] init];

    if (array.count != 0)
    {
        NSArray *USERArray =[self removesameFenceWithArray:array];
        for (Fence *fence in USERArray)
        {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
            [dic setObject:fence.fenceName forKey:@"1"];
            [dic setObject:fence.fenceID forKey:@"2"];
            [dic setObject:fence.fenceRadius forKey:@"3"];
            [dic setObject:fence.alarmContent forKey:@"4"];
            [dic setObject:fence.fenceCenter forKey:@"5"];
            [dic setObject:fence.alarmTime forKey:@"6"];
            [tableData addObject:dic];
        }
        NSLog(@"触发的围栏结果%@",tableData);
    }
    
    
    [MCHTTPRequest getUserActionLogWithWaybillNumber:_waybillNumberTextField.stringValue success:^(NSArray *array)
     {
         for (MCData *logData in array)
         {
             NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
             [dic setObject:logData.createTime forKey:@"1"];
             [dic setObject:logData.log forKey:@"2"];
             NSString *GPS = [NSString stringWithFormat:@"(%ld,%ld)",logData.lon,logData.lat];
             [dic setObject:logData.deviceModel forKey:@"3"];
             [dic setObject:GPS forKey:@"4"];
             [dic setObject:logData.appVer forKey:@"5"];
             [tableData2 addObject:dic];
         }
         
         
         MCContentVC *contentVC  = [[MCContentVC alloc]init];
         contentVC.waybillnummber = _waybillNumberTextField.stringValue;
         contentVC.tableData = tableData;
         contentVC.tableData2 = tableData2;
         
         contentVC.createdFenceData = _createdFenceArray;
         
         
         [self presentViewControllerAsModalWindow:contentVC];
         
     } failure:^(NSString *error) {
         NSLog(@"失败了");
         
         
     }];
    
}

- (void)querryFenceTigerWithArray:(NSMutableArray *)array1
{
    if (array1.count > 0)
    {
        Fence *fence = [array1 objectAtIndex:0];
        
        [MCHTTPRequest getFenceAlarmWithFenceID:fence.fenceID success:^(NSArray *array)
        {
            if (array.count> 0)
            {
                NSLog(@"围栏id : %@ ,触发 次数 %d",fence.fenceID,(int)array.count);
                
              for (NSDictionary *dict in array)
              {
                  Fence *tiggerFence = [[Fence alloc]init];
                  
                  tiggerFence.fenceID = fence.fenceID;
                  
                  int index = [[dict objectForKey:@"action"] intValue];
                  
                  if (index == 1)
                  {
                      tiggerFence.alarmContent = @"进入";
                  }
                  else
                  {
                      tiggerFence.alarmContent = @"离开";
                  }

                  long longTime = [[dict objectForKey:@"time"] longValue];

                  //将时间戳转换为格式化时间
                  NSString *stringTime = [NSString stringWithFormat:@"%ld",longTime];
                  NSDate *timeStr = [NSDate dateWithTimeIntervalSince1970: [stringTime doubleValue]];
                  NSDateFormatter *dateFormatStr = [[NSDateFormatter alloc] init];
                  dateFormatStr.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
                  [dateFormatStr setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                  NSString *triggerTime = [dateFormatStr stringFromDate:timeStr];
                  
                  NSArray *array = [fence.fenceName componentsSeparatedByString:@"_"];
                  NSString * name= [NSString stringWithFormat:@"%@_%@_%@",array[1],array[2],array[3]];
                  
                  tiggerFence.alarmTime = triggerTime;
                  tiggerFence.fenceName = name;
                  tiggerFence.fenceCenter = fence.fenceCenter;
                  tiggerFence.fenceRadius = fence.fenceRadius;
                  [_trigerFenceArray addObject:tiggerFence];
                  NSLog(@"~~~~~~~~~~%@",_trigerFenceArray);
                  

              }
            }
            [array1 removeObjectAtIndex:0];
            [self querryFenceTigerWithArray:array1];
            
     }
                                                 failure:^(NSString *error)
                  {
                      [self showErrorMessageWithTitle:@"错误提示" content:@"运单不存在!"];
                      
                  }];
    }
    else
    {
        [self getTableDataWithArray:_trigerFenceArray];
        NSLog(@"____被触发的是%@",_trigerFenceArray);
    }
}


- (NSArray *)removesameFenceWithArray:(NSArray *)array
{
    NSSet *set = [NSSet setWithArray:array];
    NSArray *array2 = [set allObjects];
    
  array2=  (NSMutableArray *)[array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2)
    {
        Fence *fence1 = obj1;
        Fence *fence2 = obj2;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
       
        NSDate *date1 = [formatter dateFromString:fence1.alarmTime];
        NSDate *date2 = [formatter dateFromString:fence2.alarmTime];
        NSComparisonResult result = [date1 compare:date2];
        return result == NSOrderedAscending;
    }];
    //排序
    return array2;
}


@end
