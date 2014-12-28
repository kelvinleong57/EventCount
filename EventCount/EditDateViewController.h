//
//  EditDateViewController.h
//  EventCount
//
//  Created by Kelvin Leong on 7/7/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Mark.h"
#import "AADatePicker.h"

@interface EditDateViewController : UIViewController

@property (nonatomic) Mark *currentMark;
@property (nonatomic) int selectedIndex;

//@property BOOL needToResort;
@property AADatePicker *datePicker;

@end