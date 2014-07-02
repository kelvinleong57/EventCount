//
//  MasterViewController.h
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"
#import "AppDelegate.h"

#import "AddViewController.h"

@interface MasterViewController : UITableViewController <passMark>

// for passing info
@property (nonatomic, strong)NSString *labelNameString;
@property int maxDaysInt;

- (void)insertNewMark:(Mark *) mark;

@end
