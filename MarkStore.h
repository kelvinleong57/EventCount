//
//  MarkStore.h
//  EventCount
//
//  Created by Kelvin Leong on 7/2/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mark.h"

@interface MarkStore : NSObject {
    NSMutableArray *allMarks;
}

-(NSString *)itemArchivePath;
-(BOOL)saveChanges;

- (void)createMarkWithLabel:(NSString *)label andDays:(int)days;
- (void)removeMark:(Mark *)m;
- (void)moveItemAtIndex:(int)from toIndex:(int)to;

- (NSArray *) allMarks;

+ (MarkStore *)sharedStore;

@end