//
//  Fence.h
//  MCCamleTools
//
//  Created by Marcus on 16/6/2.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fence : NSObject
///围栏ID
@property (nonatomic,copy) NSString *fenceID;
///围栏名称
@property (nonatomic,copy) NSString *fenceName;
///围栏中心坐标
@property (nonatomic,copy) NSString *fenceCenter;
///围栏半径
@property (nonatomic,copy) NSString *fenceRadius;
///围栏触发类型
@property (nonatomic,copy) NSString *alarmContent;
///围栏触发时间
@property (nonatomic,copy) NSString *alarmTime;
///观察者
@property (nonatomic,copy) NSString *monitoredPersons ;

- (instancetype)initWithDictionary:(NSDictionary *)dict;

@end
