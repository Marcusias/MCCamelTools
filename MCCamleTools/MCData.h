//
//  MCData.h
//
//  Created by   on 16/6/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MCData : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double dataIdentifier;
@property (nonatomic, strong) NSString *actionLog;
@property (nonatomic, assign) long lon;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *logType;
@property (nonatomic, assign) long lat;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *deviceId;
@property (nonatomic, strong) NSString *appVer;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *transNumber;
@property (nonatomic, strong) NSString *deviceModel;
@property (nonatomic, copy) NSString *log;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
