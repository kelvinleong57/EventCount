//
//  DetailViewController.h
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mark.h"
#import "MasterViewController.h"

@interface DetailViewController : UIViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *detailViewControllerTitle;
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (nonatomic) Mark *currentMark;

//@property NSMutableArray *datesUsed;

@property (weak, nonatomic) IBOutlet UILabel *maxDaysLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingDaysLabel;

@property (weak, nonatomic) IBOutlet UIButton *minusOneUsedButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
