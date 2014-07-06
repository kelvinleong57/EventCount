//
//  Mark.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "Mark.h"

@implementation Mark

@synthesize label, maxDays, remainingDays;

- (void) set:(NSString *)labelz days:(int)maxDayz {
    self.label = labelz;
    self.maxDays = maxDayz;
    self.remainingDays = maxDayz;
}

#pragma mark - Protocol Methods (NSCoding)

-(void) encodeWithCoder:(NSCoder *)aCoder {
    NSLog(@"encoding");
    [aCoder encodeObject:self.label forKey:@"label"];
    [aCoder encodeInt:self.maxDays forKey:@"maxDays"];
    [aCoder encodeInt:self.remainingDays forKey:@"remainingDays"];
}

-(instancetype) initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"decoding");
    self = [super init];
    if (self) {
        label = [aDecoder decodeObjectForKey:@"label"];
        maxDays = [aDecoder decodeIntForKey:@"maxDays"];
        remainingDays = [aDecoder decodeIntForKey:@"remainingDays"];
    }
    
    return self;
}



//- (id)initWithCoder:(NSCoder *)decoder {
//    if (self = [super init]) {
//        self.label = [decoder decodeObjectForKey:@"label"];
//        self.maxDays = [decoder decodeIntForKey:@"maxDays"];
//        self.remainingDays = [decoder decodeIntForKey:@"remainingDays"];
//    }
//    return self;
//}
//
//- (void)encodeWithCoder:(NSCoder *)encoder {
//    NSLog(@"encoding");
//
//    [encoder encodeObject:label forKey:@"label"];
//    [encoder encodeInt:maxDays forKey:@"maxDays"];
//    [encoder encodeInt:remainingDays forKey:@"remainingDays"];
//}

@end
