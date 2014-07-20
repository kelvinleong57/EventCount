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
#import "MarkStore.h"
#import "Mark.h"
#import "EditDateViewController.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

@synthesize detailViewControllerTitle, maxDaysLabel, remainingDaysLabel, currentMark;

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    detailViewControllerTitle.title = currentMark.label;
    maxDaysLabel.text = [NSString stringWithFormat:@"%i", currentMark.maxDays];
    remainingDaysLabel.text = [NSString stringWithFormat:@"%i", currentMark.remainingDays];
}

- (void) noMoreDaysAlert {
    NSString *msg = [NSString stringWithFormat:@"There are 0 days remaining for %@.", currentMark.label];
    
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Notice"
                                                      message:msg
                                                     delegate:nil
                                            cancelButtonTitle:@"Okay"
                                            otherButtonTitles:nil, nil];
    [myAlert show];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self.tableView setSeparatorColor:[UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.0]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    self.tableView.layer.borderWidth = 1.0;
    self.tableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self configureView];
    
    if (currentMark.remainingDays == 0)
        [self noMoreDaysAlert];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
    [self autoScrollToBottom:0];
}

- (void)autoScrollToBottom:(int)cellHeight {
    // cellHeight to adjust for not reloading data in pressMinuOneUsed
    // if not, this method would not scroll/account for the newest item added
    
    if (self.tableView.contentSize.height + cellHeight >= self.tableView.frame.size.height) {
        CGPoint offset = CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height + cellHeight);
        [self.tableView setContentOffset:offset animated:YES];
    }
}

- (IBAction)pressMinusOneUsed:(id)sender {
    if (currentMark.remainingDays == 0) {
        [self noMoreDaysAlert];
        return;
    }
    
    currentMark.remainingDays--;
    
    if (!currentMark.datesUsed) {
        currentMark.datesUsed = [[NSMutableArray alloc] init];
    }
    
    NSDate *today = [NSDate date];
    [currentMark.datesUsed addObject:today];

    // adding animation for adding to bottom
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[currentMark.datesUsed count]-1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    [self.tableView reloadData];
    [self autoScrollToBottom:28];
    
    [self configureView];
}

- (IBAction)resetAction:(id)sender {
    UIAlertView *myAlert = [[UIAlertView alloc] initWithTitle:@"Confirm"
                                                      message:@"Are you sure you want to reset your uses? All previous dates/uses will be erased."
                                                     delegate:self
                                            cancelButtonTitle:@"No"
                                            otherButtonTitles:@"Reset", nil];
    [myAlert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == [alertView cancelButtonIndex]){}
    else {
        [currentMark.datesUsed removeAllObjects];
        currentMark.remainingDays = currentMark.maxDays;
        
        [self configureView];
                
        [self.tableView reloadData];
    }
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [currentMark.datesUsed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
    }
    
    NSDate *date = [currentMark.datesUsed objectAtIndex:[indexPath row]];
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
//    [dateFormat setDateFormat:@"EEEE: MMMM d, YYYY"];
    [dateFormat setDateFormat:@"EEE: MMMM d"];
    cell.textLabel.text = [dateFormat stringFromDate:date];

    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [currentMark.datesUsed removeObjectAtIndex:indexPath.row];
        currentMark.remainingDays++;
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self configureView];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    int counts = [currentMark.datesUsed count];
    
    if (counts <= 5)
        return 35;
    if (counts <= 8)
        return 30;
    
    // if (counts < 8)
    return 28;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"editDate"]) {
        EditDateViewController *edvc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [edvc setCurrentMark:currentMark];
        [edvc setSelectedIndex:indexPath.row];
    }
}

@end
