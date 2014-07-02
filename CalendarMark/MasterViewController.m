//
//  MasterViewController.m
//  CalendarMark
//
//  Created by Kelvin Leong on 6/27/14.
//  Copyright (c) 2014 Kelvin Leong. All rights reserved.
//

#import "MasterViewController.h"

#import "Mark.h"
#import "DetailViewController.h"
#import "AddViewController.h"

#import "Data.h"

@interface MasterViewController () {
    NSMutableArray *_marks;
}
@end

@implementation MasterViewController

@synthesize labelNameString, maxDaysInt;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    // FOR TESTING PURPOSES
    
    Mark *testMark = [[Mark alloc] init];
    testMark.label = @"Test";
    testMark.maxDays = 18;
    testMark.remainingDays = 18;
    [self insertNewMark: testMark];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewMark:(Mark *) mark {
    if (!_marks) {
        _marks = [[NSMutableArray alloc] init];
    }
    
    [_marks insertObject:mark atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _marks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    Mark *obj = _marks[indexPath.row];
    cell.textLabel.text = [obj label];
    
    // remaining days
    NSString *remainingDaysString = [NSString stringWithFormat:@"Remaining: %i", [obj remainingDays]];
    
    cell.detailTextLabel.text = remainingDaysString;
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
        [_marks removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        DetailViewController *dvc = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Mark *m = _marks[indexPath.row];
        [dvc setCurrentMark:m];
        [dvc setDetailItem:m];
    }
    
    if ([[segue identifier] isEqualToString:@"addView"]) {
        UINavigationController *navController = segue.destinationViewController;
        AddViewController *avc = (AddViewController *)navController.topViewController;
        [avc setDelegate:self];
    }
}

-(void) viewDidAppear:(BOOL)animated {
    
    // to prevent adding a new Mark every time MasterViewController appeares
    if (labelNameString.length > 0) {
        if (!_marks) {
            _marks = [[NSMutableArray alloc] init];
        }
        
        Mark *mark = [[Mark alloc] init];
        
        [mark setLabel:labelNameString];
        [mark setMaxDays:maxDaysInt];
        [mark setRemainingDays:maxDaysInt];
        
        [_marks insertObject:mark atIndex:_marks.count];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:_marks.count-1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        // dump previous values
        labelNameString = @"";
        maxDaysInt = -5;
    }
}

- (void)someFunction{
    Data *data = [Data sharedData];
    data.username = @"Username";
}

#pragma mark - Protocol Methods

-(void)setLabelName:(NSString *)labelName {
    labelNameString = labelName;
}
-(void)setMaxDays:(int)maxDays {
    maxDaysInt = maxDays;
}

@end
