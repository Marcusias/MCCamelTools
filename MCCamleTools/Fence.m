//
//  Fence.m
//  MCCamleTools
//
//  Created by Marcus on 16/6/2.
//  Copyright © 2016年 Marcus. All rights reserved.
//

#import "Fence.h"

@implementation Fence
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self == [super init])
    {
        self.fenceID = [dict objectForKey:@"fence_id"];
        self.fenceName = [dict objectForKey:@"name"];
        NSDictionary *centerDictionary = [dict objectForKey:@"center"];
        NSString *lonString = [[centerDictionary objectForKey:@"longitude"]stringValue];
        NSString *latString = [[centerDictionary objectForKey:@"latitude"]stringValue];
        NSString *centerString = [NSString stringWithFormat:@"(%@,%@)",lonString,latString];
        self.fenceCenter=centerString;
        self.fenceRadius= [dict objectForKey:@"radius"];
        NSArray * array = [dict objectForKey:@"monitored_persons"];
        if (array.count > 0)
        {
             self.monitoredPersons = [array objectAtIndex:0];
        }
       
    }
    return self;
}
@end
