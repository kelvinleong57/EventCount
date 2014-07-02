//
//  InfoViewController.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/30/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
