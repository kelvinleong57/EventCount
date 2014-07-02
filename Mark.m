//
//  Mark.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "Mark.h"

@implementation Mark

- (void) set:(NSString *)label days:(int)maxDays {
    self.label = label;
    self.maxDays = maxDays;
    self.remainingDays = maxDays;
}


@end
