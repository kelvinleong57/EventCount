//
//  Data.m
//  CalendarMark
//
//  Created by Kelvin Leong on 7/2/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "Data.h"

static Data *sharedData = nil;

@implementation Data
@synthesize username, password, accountType, marks;

#pragma mark -
#pragma mark Singleton Methods

+ (Data *)sharedData {
    if(sharedData == nil){
        sharedData = [[super allocWithZone:NULL] init];
    }
    return sharedData;
}

@end