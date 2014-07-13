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

#import "MarkStore.h"

@interface MasterViewController ()
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidAppear:(BOOL)animated {
    // reload table data each time to update remaining days
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
//    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:[[[MarkStore sharedStore] allMarks] count]-1 inSection:0];
//    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
//    [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
}




#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[MarkStore sharedStore] allMarks] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    Mark *obj = [[[MarkStore sharedStore] allMarks] objectAtIndex:[indexPath row]];
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
        MarkStore *ms = [MarkStore sharedStore];
        NSArray *items = [ms allMarks];
        Mark *m = [items objectAtIndex:[indexPath row]];
        [ms removeMark:m];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [[MarkStore sharedStore] moveItemAtIndex:[fromIndexPath row] toIndex:[toIndexPath row]];
}

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
        
        Mark *m = [[MarkStore sharedStore] allMarks][indexPath.row];
        
        [dvc setCurrentMark:m];
        [dvc setDetailItem:m];
    }
    
    if ([[segue identifier] isEqualToString:@"addView"]) {
//        UINavigationController *navController = segue.destinationViewController;
//        AddViewController *avc = (AddViewController *)navController.topViewController;
//        [avc setDelegate:self];
    }
}

@end
