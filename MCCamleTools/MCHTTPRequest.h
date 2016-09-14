//
//  MCHTTPRequest.h
//  CamelTest
//
//  Created by Marcus on 16/1/14.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MCHTTPRequest : NSObject
+ (void)getBaiduFenceListWithWaybillNumber:(NSString *)waybillNumber success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock;

+ (void)getFenceAlarmWithFenceID:(NSString *)fenceID success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock;

+ (void)getUserActionLogWithWaybillNumber:(NSString *)waybillNumber success:(void(^)(NSArray *array))successBlock failure:(void(^)(NSString *error))failureBlock;
@end
