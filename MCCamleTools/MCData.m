//
//  MCData.m
//
//  Created by   on 16/6/27
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "MCData.h"


NSString *const kMCDataId = @"id";
NSString *const kMCDataActionLog = @"action_log";
NSString *const kMCDataLon = @"lon";
NSString *const kMCDataMobile = @"mobile";
NSString *const kMCDataLogType = @"log_type";
NSString *const kMCDataLat = @"lat";
NSString *const kMCDataAddress = @"address";
NSString *const kMCDataDeviceId = @"device_id";
NSString *const kMCDataAppVer = @"app_ver";
NSString *const kMCDataCreateTime = @"create_time";
NSString *const kMCDataTransNumber = @"trans_number";
NSString *const kMCDataDeviceModel = @"device_model";


@interface MCData ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation MCData

@synthesize dataIdentifier = _dataIdentifier;
@synthesize actionLog = _actionLog;
@synthesize lon = _lon;
@synthesize mobile = _mobile;
@synthesize logType = _logType;
@synthesize lat = _lat;
@synthesize address = _address;
@synthesize deviceId = _deviceId;
@synthesize appVer = _appVer;
@synthesize createTime = _createTime;
@synthesize transNumber = _transNumber;
@synthesize deviceModel = _deviceModel;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.dataIdentifier = [[self objectOrNilForKey:kMCDataId fromDictionary:dict] doubleValue];
            self.actionLog = [self objectOrNilForKey:kMCDataActionLog fromDictionary:dict];
            self.lon = [[self objectOrNilForKey:kMCDataLon fromDictionary:dict] longLongValue];
            self.mobile = [self objectOrNilForKey:kMCDataMobile fromDictionary:dict];
            self.logType = [self objectOrNilForKey:kMCDataLogType fromDictionary:dict];
            self.lat = [[self objectOrNilForKey:kMCDataLat fromDictionary:dict] longLongValue];
            self.address = [self objectOrNilForKey:kMCDataAddress fromDictionary:dict];
            self.deviceId = [self objectOrNilForKey:kMCDataDeviceId fromDictionary:dict];
            self.appVer = [self objectOrNilForKey:kMCDataAppVer fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kMCDataCreateTime fromDictionary:dict];
            self.transNumber = [self objectOrNilForKey:kMCDataTransNumber fromDictionary:dict];
            self.deviceModel = [self objectOrNilForKey:kMCDataDeviceModel fromDictionary:dict];
            NSArray *arr = [self.logType componentsSeparatedByString:@"_"];
        if (arr.count != 0)
        {
            int index = [[arr objectAtIndex:1]intValue];
            int intidifer = [[arr objectAtIndex:2]intValue];
            switch (index)
            {
                case 1:
                    switch (intidifer)
                    {
                        case 1:
                            self.log = @"进入后台";
                            break;
                        case 2:
                            self.log = @"进入了前台";
                            break;
                        case 3:
                            self.log = @"进程被杀";
                            break;
                        case 4:
                            self.log = @"应用被打开";
                            break;
                        case 5:
                            self.log = @"当前无网络";
                            break;
                        case 6:
                            self.log = @"极光推送别名设置失败";
                            break;
                        default:
                            self.log = @"用户未知错误";
                            break;
                    }
                    
                    break;
                case 2:
                    switch (intidifer)
                    {
                        case 1:
                            self.log = @"正在开启鹰眼";
                            break;
                        case 2:
                            self.log = @"开启鹰眼失败";
                            break;
                        default:
                            self.log = @"鹰眼未知错误";
                            break;
                    }
                    break;
                case 3:
                    switch (intidifer)
                {
                    case 1:
                        self.log = @"收到鹰眼触发";
                        break;
                    case 2:
                        self.log = @"上报触发成功";
                        break;
                    case 3:
                        self.log = @"上报触发失败";
                        break;
                    case 4:
                        self.log = @"收到离线触发";
                        break;
                    default:
                        self.log = @"触发未知错误";
                        break;
                }
                default:
                    break;
            }
        }
        

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dataIdentifier] forKey:kMCDataId];
    [mutableDict setValue:self.actionLog forKey:kMCDataActionLog];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lon] forKey:kMCDataLon];
    [mutableDict setValue:self.mobile forKey:kMCDataMobile];
    [mutableDict setValue:self.logType forKey:kMCDataLogType];
    [mutableDict setValue:[NSNumber numberWithDouble:self.lat] forKey:kMCDataLat];
    [mutableDict setValue:self.address forKey:kMCDataAddress];
    [mutableDict setValue:self.deviceId forKey:kMCDataDeviceId];
    [mutableDict setValue:self.appVer forKey:kMCDataAppVer];
    [mutableDict setValue:self.createTime forKey:kMCDataCreateTime];
    [mutableDict setValue:self.transNumber forKey:kMCDataTransNumber];
    [mutableDict setValue:self.deviceModel forKey:kMCDataDeviceModel];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.dataIdentifier = [aDecoder decodeDoubleForKey:kMCDataId];
    self.actionLog = [aDecoder decodeObjectForKey:kMCDataActionLog];
    self.lon = [aDecoder decodeDoubleForKey:kMCDataLon];
    self.mobile = [aDecoder decodeObjectForKey:kMCDataMobile];
    self.logType = [aDecoder decodeObjectForKey:kMCDataLogType];
    self.lat = [aDecoder decodeDoubleForKey:kMCDataLat];
    self.address = [aDecoder decodeObjectForKey:kMCDataAddress];
    self.deviceId = [aDecoder decodeObjectForKey:kMCDataDeviceId];
    self.appVer = [aDecoder decodeObjectForKey:kMCDataAppVer];
    self.createTime = [aDecoder decodeObjectForKey:kMCDataCreateTime];
    self.transNumber = [aDecoder decodeObjectForKey:kMCDataTransNumber];
    self.deviceModel = [aDecoder decodeObjectForKey:kMCDataDeviceModel];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeDouble:_dataIdentifier forKey:kMCDataId];
    [aCoder encodeObject:_actionLog forKey:kMCDataActionLog];
    [aCoder encodeDouble:_lon forKey:kMCDataLon];
    [aCoder encodeObject:_mobile forKey:kMCDataMobile];
    [aCoder encodeObject:_logType forKey:kMCDataLogType];
    [aCoder encodeDouble:_lat forKey:kMCDataLat];
    [aCoder encodeObject:_address forKey:kMCDataAddress];
    [aCoder encodeObject:_deviceId forKey:kMCDataDeviceId];
    [aCoder encodeObject:_appVer forKey:kMCDataAppVer];
    [aCoder encodeObject:_createTime forKey:kMCDataCreateTime];
    [aCoder encodeObject:_transNumber forKey:kMCDataTransNumber];
    [aCoder encodeObject:_deviceModel forKey:kMCDataDeviceModel];
}

- (id)copyWithZone:(NSZone *)zone
{
    MCData *copy = [[MCData alloc] init];
    
    if (copy) {

        copy.dataIdentifier = self.dataIdentifier;
        copy.actionLog = [self.actionLog copyWithZone:zone];
        copy.lon = self.lon;
        copy.mobile = [self.mobile copyWithZone:zone];
        copy.logType = [self.logType copyWithZone:zone];
        copy.lat = self.lat;
        copy.address = [self.address copyWithZone:zone];
        copy.deviceId = [self.deviceId copyWithZone:zone];
        copy.appVer = [self.appVer copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.transNumber = [self.transNumber copyWithZone:zone];
        copy.deviceModel = [self.deviceModel copyWithZone:zone];
    }
    
    return copy;
}


@end
