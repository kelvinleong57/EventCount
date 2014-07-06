//
//  AddViewController.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "MasterViewController.h"
#import "AddViewController.h"
#import "AppDelegate.h"

#import "MarkStore.h"

@interface AddViewController ()
@end

@implementation AddViewController

//@synthesize delegate, labelNameString, maxDaysInt;
@synthesize labelNameString, maxDaysInt;

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES]; // all controls forced to give up first responder status
}

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)sliderValueChanged:(id)sender {
    [self.stepper setValue: (int)self.slider.value];
    NSString *str = [NSString stringWithFormat:@"%i", (int)self.slider.value];
    self.totalUsesLabel.text = str;
}
- (IBAction)stepperValueChanged:(id)sender {
    [self.slider setValue: (int)self.stepper.value];
    NSString *str = [NSString stringWithFormat:@"%i", (int)self.slider.value];
    self.totalUsesLabel.text = str;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)infoViewControllerDidFinish:(InfoViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(UIBarButtonItem *)sender {
    if (_labelName.text.length > 0) {    
        float sliderVal = [_slider value];

        labelNameString = _labelName.text;
        maxDaysInt = (int) sliderVal;
        
        [[MarkStore sharedStore] createMarkLabel:labelNameString withDays:maxDaysInt];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        
        // not finished
        UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"It appears that you have not finished filling out everything." delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [myAlert show];
    }
}
@end
