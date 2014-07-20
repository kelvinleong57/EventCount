//
//  EditDateViewController.m
//  EventCount
//
//  Created by Kelvin Leong on 7/7/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "EditDateViewController.h"

@implementation EditDateViewController

@synthesize selectedIndex, currentMark, datePicker, needToResort;

- (void)viewDidLoad {
    NSDate *defaultDate = currentMark.datesUsed[selectedIndex];
    datePicker.date = defaultDate;
    
    [self configureDates];
}

- (void)configureDates {
    needToResort = false; // default
    
    datePicker.maximumDate = [NSDate date];
    
    // first index
    if (selectedIndex == 0) {
        
        // there is more than one date, so use the next date as max
        if ([currentMark.datesUsed count] > 1)
            datePicker.maximumDate = currentMark.datesUsed[selectedIndex + 1];
        
        // if only one, it will return anyway
        return;
    }
    
    // last index should NOT have minimum, in case user creates new date and wants it to be moved somewhere
    if (selectedIndex == [currentMark.datesUsed count] - 1) {
        needToResort = true;
        return;
    }
    
    // default with a before and after
    datePicker.minimumDate = currentMark.datesUsed[selectedIndex - 1];
    datePicker.maximumDate = currentMark.datesUsed[selectedIndex + 1];
}

- (IBAction)save:(id)sender {
    // change the date of the index
    currentMark.datesUsed[selectedIndex] = datePicker.date; // will be erased anyway in if statement
    
    if (needToResort) {
        NSDate *resort = datePicker.date;
        
        [currentMark.datesUsed removeObjectAtIndex:[currentMark.datesUsed count] - 1]; // remove last, which is what was changed
        selectedIndex--; // to account for the removal
        
        // find spot for the changed date
        while (selectedIndex >= 0 && ([resort earlierDate:currentMark.datesUsed[selectedIndex]] == resort))
            selectedIndex--;
        
        selectedIndex++; // index of where the object goes (loop goes 1 further)
        
        [currentMark.datesUsed insertObject:resort atIndex:selectedIndex];
        
    }
    
    [[[self.navigationController viewControllers] objectAtIndex:1] viewDidLoad];
    
    // hard-code the View Controller at position 1
    [self.navigationController popToViewController:[[self.navigationController viewControllers] objectAtIndex:1] animated:YES];
}


@end