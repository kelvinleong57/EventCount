//
//  MasterViewController.h
//  EventCount
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"
#import "AppDelegate.h"

#import "AddViewController.h"

//@protocol NSCoding
//
//- (void)encodeWithCoder:(NSCoder *)aCoder;
//- (id)initWithCoder:(NSCoder *)aDecoder;
//
//@end

@interface MasterViewController : UITableViewController <passMark>

// for passing info
@property (nonatomic, strong)NSString *labelNameString;
@property int maxDaysInt;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
