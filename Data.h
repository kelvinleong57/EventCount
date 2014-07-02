//
//  Data.h
//  CalendarMark
//
//  Created by Kelvin Leong on 7/2/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Mark.h"

@interface Data : NSObject {
    NSString *username;
    NSString *password;
    NSString *accountType;
    
    NSArray *marks;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *accountType;
@property NSArray *marks;
+ (Data *)sharedData;

@end