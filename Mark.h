//
//  Mark.h
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mark : NSObject <NSCoding> {
    NSString *label;
    int maxDays;
    int remainingDays;
}

@property (nonatomic) NSString *label;
@property (nonatomic) int maxDays;
@property (nonatomic) int remainingDays;

@property (nonatomic) NSMutableArray *datesUsed;

- (void) set:(NSString *)label days:(int)maxDays;

@end
