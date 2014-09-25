//
//  RZGoalDetailViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalDetailViewController.h"
#import "RZMilestoneDetailViewController.h"

//TODO: RZ 20140912 Recreatable crash!  If you drag the milestone table view up so that the cells disappear under the top view, and also trigger the cell select, causing a navigation event, a nested push causes an application crash.  It's repeatable even though it's difficult to trigger.  Just keep dragging the tableview up.  My guess is that it has to do with the setSelected triggering the segue but no idea why that is.  


@interface RZGoalDetailViewController ()

@end

@implementation RZGoalDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [[self tableView] setDelegate:self];
    [[self tableView] setDataSource:self];
    
    [self setTitle:@"Goal"];
    
    [[self tableView] registerNib:[UINib nibWithNibName:@"MilestoneTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"milestoneCell"];

    
    [[self titleLabel] setText:[[self goalViewModel] title]];
    [[self summaryTextView] setText:[[self goalViewModel] summary]];
    [[self statusLabel] setText:[[[self goalViewModel] status] title]];
    [[self statusLabel] setTextColor:[[[self goalViewModel] status] color]];
    //[[self dateDueLabel] setText:[[self goalViewModel] dateDue]];
    //[[self timeRemainingLabel] setText:[[self goalViewModel] timeRemaining]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // this UIViewController is about to re-appear, if the selection persists, it can cause trouble with selecting the next cell and triggering disapplowed nested segues
    NSIndexPath *tableSelection = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:tableSelection animated:YES];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self goalViewModel] milestones] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMilestoneCell *cell = (RZMilestoneCell *)[tableView dequeueReusableCellWithIdentifier:[RZMilestoneCell defaultReuseIdentifier] forIndexPath:indexPath];
	[cell setDelegate:self];
    
    RZMilestoneViewModel *viewModel = [[[self goalViewModel] milestones] objectAtIndex:indexPath.row];
    [cell setMilestoneViewModel:viewModel];
    return cell;
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;

}

#pragma mark ReOrdering

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath
{
    if (sourceIndexPath.section != proposedDestinationIndexPath.section) {
        NSInteger row = 0;
        if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
            row = [tableView numberOfRowsInSection:sourceIndexPath.section] - 1;
        }
        return [NSIndexPath indexPathForRow:row inSection:sourceIndexPath.section];
    }
    
    return proposedDestinationIndexPath;
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
}


#pragma mark - RZMilestoneEditViewControllerDelegate / RZMilestoneDetailViewControllerDelegate


- (void)milestoneEditViewControllerDidCancel:(RZMilestoneEditViewController *)controller{
    // really nothing to do here
}

- (void)rzMilestoneDetailViewController:(id)viewController milestoneDataDidChange:(RZMilestoneViewModel *)milestoneViewModel{
    [self updateViewModelForMilestone:milestoneViewModel];
}

- (void)milestoneEditViewController:(RZMilestoneEditViewController *)controller didUpdateMilestone:(RZMilestoneViewModel *)milestoneViewModel{
    [self updateViewModelForMilestone:milestoneViewModel];
}

- (void)updateViewModelForMilestone:(RZMilestoneViewModel *)milestoneViewModel{
    RZGoalViewModel *goalVM = [self goalViewModel];
    [goalVM saveMilestone:milestoneViewModel];
    // Refresh the view model and reload the table view
    [self setGoalViewModel:[goalVM refreshedCopy]];
    [[self tableView] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    if( [self delegate] != nil){
        [[self delegate] rzGoalDetailViewController:self goalDataDidChange:goalVM];
    }
}




#pragma mark - RZMilestoneCellDelegate

- (void)didSelectMilestoneCell:(RZMilestoneCell *)cell{
    //NSIndexPath *path = [[self tableView] indexPathForCell:cell];
    [self performSegueWithIdentifier:@"milestoneDetailSegue" sender:self];
}

- (void)rzMilestoneCell:(id)milestoneCell didUpdateStatusOnMilestone:(RZMilestoneViewModel *)milestoneViewModel{
    RZGoalViewModel *goal = [self goalViewModel];
    [goal saveMilestone:milestoneViewModel];
    RZMilestoneCell *cell = (RZMilestoneCell *)milestoneCell;
    [cell animateTransitionToCurrentStatus];
}


#pragma mark - Storyboard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"milestoneDetailSegue"]) {
        RZMilestoneDetailViewController *vc = (RZMilestoneDetailViewController *)[segue destinationViewController];
        NSIndexPath *selectedRowIndex = [[self tableView] indexPathForSelectedRow];
        RZMilestoneViewModel *milestoneViewModel = [[[self goalViewModel] milestones] objectAtIndex:selectedRowIndex.row];
        [vc setMilestoneViewModel:milestoneViewModel];
        [vc setDelegate:self];
    }
    else if([[segue identifier] isEqualToString:@"addMilestoneToGoalSegue"])
    {

        RZGoalViewModel *goalVM = [self goalViewModel];
        NSString *goalTitle = [goalVM title];
        RZMilestoneViewModel *milestoneVM = [[RZMilestoneViewModel alloc] initWithMilestone:nil];
        [milestoneVM setGoalTitle:goalTitle];
        UINavigationController *navigationController = [segue destinationViewController];
        RZMilestoneEditViewController *destinationVC = [[navigationController viewControllers] objectAtIndex:0];
        [destinationVC setDelegate:self];
        [destinationVC setMilestoneViewModel:milestoneVM];

    }
    
}
#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
