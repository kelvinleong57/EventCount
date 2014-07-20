//
//  MarkStore.m
//  EventCount
//
//  Created by Kelvin Leong on 7/2/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "MarkStore.h"
#import "Mark.h"

@implementation MarkStore

-(id) init {
    self = [super init];
    
    if (self) {
        NSString *path = [self itemArchivePath];
        allMarks = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        // If the array hadn't been saved previously, create a new empty one
        if (!allMarks)
            allMarks = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) createMarkWithLabel:(NSString *)label andDays:(int)days {
    if (!allMarks)
        allMarks = [[NSMutableArray alloc] init];
    
    Mark *obj = [[Mark alloc] init];
    obj.label = label;
    obj.maxDays = days;
    obj.remainingDays = days;
    
    [allMarks addObject:obj];
}

- (void)removeMark:(Mark *)m {
    [allMarks removeObject:m];
}

- (void)moveItemAtIndex:(int)from toIndex:(int)to {
    if (from == to)
        return;

    Mark *m = [allMarks objectAtIndex:from];
    
    [allMarks removeObjectAtIndex:from];
    [allMarks insertObject:m atIndex:to];
}

- (NSArray *) allMarks {
    return allMarks;
}

// archiving
    
-(NSString *) itemArchivePath {
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    // get one and only document directory from that list
    NSString *documentDirectory = [documentDirectories firstObject];
    
    return [documentDirectory stringByAppendingPathComponent:@"marks.archive"];
}

-(BOOL) saveChanges {
    // returns success or failure
    NSString *path = [self itemArchivePath];
    
    return [NSKeyedArchiver archiveRootObject:allMarks toFile:path];
}

+ (MarkStore *)sharedStore {
    static MarkStore *sharedStore = nil; // static type, so only one exists

    if(!sharedStore)
        sharedStore = [[super allocWithZone:nil] init];

    return sharedStore;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedStore];
}

@end
