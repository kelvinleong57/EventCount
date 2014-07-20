//
//  AddViewController.h
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MasterViewController.h"
#import "Mark.h"

@protocol passMark <NSObject>

-(void) setLabelName:(NSString*)labelName;
-(void) setMaxDays:(int)maxDays;

@end

@interface AddViewController : UIViewController

// bar buttons
- (IBAction)cancel:(UIBarButtonItem *)sender;
- (IBAction)save:(UIBarButtonItem *)sender;

@property (retain)id <passMark> delegate;

// for transferring info across View Controllers
@property (nonatomic, strong)NSString *labelNameString;
@property int maxDaysInt;

// direct controls
@property (weak, nonatomic) IBOutlet UITextField *labelName;
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property UIStepper *stepper;

@property (weak, nonatomic) IBOutlet UILabel *totalUsesLabel;

@end
