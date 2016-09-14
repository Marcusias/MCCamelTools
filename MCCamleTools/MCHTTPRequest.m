//
//  MCHTTPRequest.m
//  CamelTest
//
//  Created by Marcus on 16/1/14.
//  Copyright © 2016年 Marcus. All rights reserved.
//


#import "MCHTTPRequest.h"
#import <AFNetworking.h>
#import "MCData.h"




@implementation MCHTTPRequest

static AFHTTPSessionManager *_session;
//初始化



+ (void)getBaiduFenceListWithWaybillNumber:(NSString *)waybillNumber success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock
{
    if (_session == nil)
    {
        _session = [AFHTTPSessionManager manager];
        _session.requestSerializer.timeoutInterval = 45;
       
        _session.responseSerializer.acceptableContentTypes = nil;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *serviceID = [userDefaults objectForKey:@"serviceID"];
    NSString *string = [NSString stringWithFormat:@"http://api.map.baidu.com/trace/v2/fence/list?ak=hiTO2TPGNbEX9MfwXRma5wGUUPVM7FbN&service_id=%@&creator=%@",serviceID,waybillNumber];
    NSURL *url = [NSURL URLWithString:string];
    
    [_session GET:url.absoluteString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSArray *fenceArray = [responseObject objectForKey:@"fences"];
         successBlock (fenceArray);
         NSLog(@"_________%@",fenceArray);
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
        failureBlock ([error localizedDescription]);
         NSLog(@"%@",[error localizedDescription]);
         
     }];

}
+ (void)getFenceAlarmWithFenceID:(NSString *)fenceID success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock
{
    if (_session == nil)
    {
        _session = [AFHTTPSessionManager manager];
        _session.requestSerializer.timeoutInterval = 45;
        _session.responseSerializer.acceptableContentTypes = nil;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *serviceID = [userDefaults objectForKey:@"serviceID"];
    
    NSString *string = [NSString stringWithFormat:@"http://api.map.baidu.com/trace/v2/fence/historyalarm"];
    NSURL *url = [NSURL URLWithString:string];
    NSDictionary *parameters = @{@"ak":@"hiTO2TPGNbEX9MfwXRma5wGUUPVM7FbN",@"service_id":serviceID,@"fence_id":fenceID};
    
    [_session GET:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"%@______%@_____%@",string,responseObject,[responseObject objectForKey:@"message"]);
         NSArray *array = [responseObject objectForKey:@"monitored_person_alarms"];
         NSArray *alarmArray =@[];
         if (array.count >0)
         {
             alarmArray = [[array objectAtIndex:0]objectForKey:@"alarms"];
         }
         NSLog(@"围栏ID:%@,触发记录:%@",fenceID,alarmArray);
         successBlock (alarmArray);
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
         failureBlock ([error localizedDescription]);
         NSLog(@"%@",[error localizedDescription]);
         
     }];

}

+ (void)getUserActionLogWithWaybillNumber:(NSString *)waybillNumber success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock
{
    if (_session == nil)
    {
        _session = [AFHTTPSessionManager manager];
        _session.requestSerializer.timeoutInterval = 45;
        
        _session.responseSerializer.acceptableContentTypes = nil;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *port = [userDefaults objectForKey:@"port"];
    NSDictionary *parameters = @{@"trans_number":waybillNumber};
    NSURL *url = [NSURL URLWithString:port];
    
    
    [_session GET:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
     {
         NSLog(@"____~~~~%@",responseObject);
         NSArray *array = [responseObject objectForKey:@"data"];
         NSMutableArray *logArray = [NSMutableArray array];
         
         for (NSDictionary *dict in array)
         {
             MCData *logData = [[MCData alloc]initWithDictionary:dict];
             [logArray addObject:logData];
         }
         successBlock (logArray);
     }
          failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
     {
         
         failureBlock ([error localizedDescription]);
         NSLog(@"%@",[error localizedDescription]);
     }];

}

+ (void)loginWithAccount:(NSString *)account password:(NSString *)password success:(void(^)(NSString *array))successBlock failure:(void(^)(NSString *error))failureBlock
{
    if (_session == nil)
    {
        _session = [AFHTTPSessionManager manager];
        _session.requestSerializer.timeoutInterval = 45;
        
        _session.responseSerializer.acceptableContentTypes = nil;
    }
   // NSString *string = [NSString stringWithFormat:@"%@/v1/auth/dispatcher/app",HOSTURL];
   // NSLog(@"%@",string);
    
    //MD5加密并转小写
   // NSString *MDPassword        = [[self md5:password]lowercaseString];
    
    // 版本
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    
    
   // NSDictionary *parameter = @{@"user_no":account,@"password":MDPassword,@"device_id":DEVICEID,@"app_ver":@"0.6.2",@"sys_ver":@"iOS10",@"device_model":@"iPhone3S",@"device_type":@"0",@"role_type":@"1"};
    // {
        int code = [[responseObject objectForKey:@"code"] intValue];
    
        //        int code = 1201;
        NSLog(@"%d",code);
        if (code == 1000) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            MYLog(@"登陆成功");
            NSString *token = [dic objectForKey:@"token"];
            NSString *username = [dic objectForKey:@"user_no"];// 工号
            NSString *location = [[dic objectForKey:@"fk_location_code"] description];
            NSString *fullname = [dic objectForKey:@"fullname"];// 姓名
            NSString *expireTime = [dic objectForKey:@"expire_time"];
            NSString *photoUrL =[dic objectForKey:@"photo_url"];// 头像
            NSString *telephone = [dic objectForKey:@"telephone"];// 电话
            NSString *locationname = [dic objectForKey:@"location_name"];// 转运中心地址
            
            if ([photoUrL isEqual:[NSNull null]])
            {
                photoUrL = @"";
            }
            if ([telephone isEqual:[NSNull null]])
            {
                telephone = @"";
            }
            
            NSDictionary *userDictionary = @{@"fullname":fullname,@"photo_url":photoUrL,@"location_code":location,@"telephone":telephone,@"photo_url":photoUrL,@"location_name":locationname};
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:token forKey:@"token"];
            [userDefault setObject:username forKey:@"username"];
            [userDefault setObject:expireTime forKey:@"expireTime"];
            [userDefault setObject:location forKey:@"location_code"];
            [userDefault setObject:fullname forKey:@"fullname"];
            [userDefault synchronize];
            
            MYLog(@"==UserToken====%@",[userDefault objectForKey:@"token"]);
            [userDefault setObject:userDictionary forKey:@"userDictionary"];
            successBlock(dic);
            
            
            
            NSString *alias = [NSString stringWithFormat:@"%@",username];
            [JPUSHService setAlias:alias callbackSelector:nil object:nil];
            
            
        } else if (code == 1102)
        {
            NSString *failureCodeString = @"该用户不存在";
            failureBlock(failureCodeString);
            佑佑  17:23:20
        } else if (code == 1204)
        {
            NSString *failureCodeString = @"调度端暂未对总调开放";
            failureBlock(failureCodeString);
            
        } else if (code == 1100)
        {
            NSString *failureCodeString = @"密码输入错误,请重新输入";
            failureBlock(failureCodeString);
            
        } else if (code == 1201) {
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            NSString *token = [dic objectForKey:@"token"];
            NSString *username = [dic objectForKey:@"user_no"];// 工号
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            [userDefault setObject:token forKey:@"token"];
            [userDefault setObject:username forKey:@"username"];
            [userDefault synchronize];
            
            NSString *failureCodeString = @"1201";
            failureBlock(failureCodeString);
            
        } else {
            NSString *failureCodeString = [self getErrorMessageWithErrorCode:code];
            failureBlock(failureCodeString);
            
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        MYLog(@"初始化失败%@",[error localizedDescription]);
        if ([[error localizedDescription] isEqualToString:@"似乎已断开与互联网的连接。"])
        {
            failureBlock (@"网络连接失败，请检查网络连接");
        }
        else if ([[error localizedDescription] isEqualToString:@"连接超时。"])
        {
            failureBlock (@"连接超时,请检查网络或稍后重试");
        }
        else
        {
            failureBlock ([error localizedDescription]);
        }
    }];
}

@end
