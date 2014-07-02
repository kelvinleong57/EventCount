//
//  Mark.h
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mark : NSObject

@property (nonatomic) NSString *label;
@property int maxDays;
@property int remainingDays;

- (void) set:(NSString *)label days:(int)maxDays;

@end
