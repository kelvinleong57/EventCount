//
//  DetailViewController.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "DetailViewController.h"
#import "MasterViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentDetail;
- (void)configureView;
@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSString *remainingDaysString = [NSString stringWithFormat:@"Remaining: %i", [self.detailItem remainingDays]];
        
        self.detailDescriptionLabel.text = remainingDaysString;
        
        _currentDetail.text = remainingDaysString; // must be modified for outlet
    }
    
    _detailViewControllerTitle.title = _currentMark.label;
    
    _maxDaysLabel.text = [NSString stringWithFormat:@"%i", _currentMark.maxDays];
    
    _remainingDaysLabel.text = [NSString stringWithFormat:@"%i", _currentMark.remainingDays];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initButtons];
    
    [self configureView];
}

- (void)initButtons {
    self.sundayButton.layer.cornerRadius = self.sundayButton.bounds.size.width/2.0;
    self.sundayButton.layer.borderWidth = 1.0;
    self.sundayButton.layer.borderColor = self.sundayButton.titleLabel.textColor.CGColor;
    self.sundayButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:5];
    self.sundayButton.titleLabel.text = @"HI";
}

- (IBAction)pressSunday:(id)sender {
    _currentMark.remainingDays--;
    
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
