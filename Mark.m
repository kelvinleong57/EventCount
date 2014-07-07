//
//  Mark.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "Mark.h"

@implementation Mark

@synthesize label, maxDays, remainingDays, datesUsed;

- (void) set:(NSString *)labelz days:(int)maxDayz {
    self.label = labelz;
    self.maxDays = maxDayz;
    self.remainingDays = maxDayz;
    
//    datesUsed = [[NSMutableArray alloc] init];
}

#pragma mark - Protocol Methods (NSCoding)

-(void) encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"encoding");
    [aCoder encodeObject:self.label forKey:@"label"];
    [aCoder encodeInt:self.maxDays forKey:@"maxDays"];
    [aCoder encodeInt:self.remainingDays forKey:@"remainingDays"];
    
    [aCoder encodeObject:self.datesUsed forKey:@"datesUsed"];
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"decoding");
    self = [super init];
    if (self) {
        label = [aDecoder decodeObjectForKey:@"label"];
        maxDays = [aDecoder decodeIntForKey:@"maxDays"];
        remainingDays = [aDecoder decodeIntForKey:@"remainingDays"];

        datesUsed = [aDecoder decodeObjectForKey:@"datesUsed"];
    }
    
    return self;
}

@end
