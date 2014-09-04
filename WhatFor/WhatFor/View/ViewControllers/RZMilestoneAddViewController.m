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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:@"Add Milestone"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[self goalTitleLabel] setText:[[self milestoneViewModel] goalTitle]];
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
    [[[self milestoneViewModel] status] setStatus:status];
    [[[self statusTableCell] textLabel] setText:[[[self milestoneViewModel] status] title]];
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
    // OK, need that interacter class to set values in a testable way...
    
	[self.delegate milestoneAddViewControllerDidSave:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
