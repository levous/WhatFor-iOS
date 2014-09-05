//
//  RZMilestoneAddViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneAddViewController.h"
#import "RZStringsHelper.h"
#import "RZActivityStatusPickerViewController.h"

@interface RZMilestoneAddViewController ()

@end

@implementation RZMilestoneAddViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setStatusViewModel:[[RZStatusViewModel alloc] init]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Add Milestone"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self goalTitleLabel] setText:[[self milestoneViewModel] goalTitle]];
    
    [self populateFromViewModel];
}

- (void)populateFromViewModel{
    [[self titleTextField] setText:[[self milestoneViewModel] title]];
    [[self summaryTextView] setText:[[self milestoneViewModel] summary]];
    [[self dueDateTextField] setText:[[self milestoneViewModel] dateDueText]];
    //[[self pointValueTextField] setText:[[self milestoneViewModel] ???]];
    [[[self statusTableCell] textLabel] setText:[[[self milestoneViewModel] status] title]];
    [[[self statusTableCell] textLabel] setTextColor:[[[self milestoneViewModel] status] color]];
    // copy status value to local status view model for temp storage
    [[self statusViewModel] setStatus:[[[self milestoneViewModel] status] status]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"pickStatusSegue"]){
        RZActivityStatusPickerViewController *destinationVC = (RZActivityStatusPickerViewController *)[segue destinationViewController];
        [destinationVC setDelegate:self];
        [destinationVC setSelectedStatus:[[[self milestoneViewModel] status] status]];
    }
}


- (void)rzactivityStatusPickerViewController:(RZActivityStatusPickerViewController *)controller
                           didSelectStatus:(RZActivityStatus)status{
    [[self statusViewModel] setStatus:status];
    [[[self statusTableCell] textLabel] setText:[[self statusViewModel] title]];
    [[[self statusTableCell] textLabel] setTextColor:[[self statusViewModel] color]];
    [[self navigationController] popViewControllerAnimated:YES];
}

#pragma mark - Bar Button Handlers

- (IBAction)cancel:(id)sender
{
	[self.delegate milestoneAddViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender
{
    RZMilestoneViewModel *mvm = [self milestoneViewModel];
    
    [mvm setTitle:[[self titleTextField] text]];
    [mvm setSummary:[[self summaryTextView] text]];
    [[mvm status] setStatus:[[self statusViewModel] status]];
    //[mvm setDateDue:[self dateDue]];
    [mvm setTitle:[[self titleTextField] text]];
    
	[self.delegate milestoneAddViewController:self didUpdateMilestone:[self milestoneViewModel]];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
