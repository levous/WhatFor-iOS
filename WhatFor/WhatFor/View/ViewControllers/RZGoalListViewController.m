//
//  RZGoalListViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalListViewController.h"
#import "ModelHeader.h"
#import "RZMilestonesHeaderCell.h"
#import "RZGoalListViewModel.h"
#import "RZMilestoneDetailViewController.h"
#import "RZGoalDetailViewController.h"
#import "RZUIStyleGuide.h"
#import "UIView+Helpers.h"

@interface RZGoalListViewController ()

@end

@implementation RZGoalListViewController

RZGoalListViewModel *goalListViewModel;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MilestoneTableCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"milestoneCell"];

    [self setTitle:@"My Goals"];
    
    goalListViewModel = [[RZGoalListViewModel alloc] initWithRepository:[self coreDataRepository] hideCompletedMilestones:self.hideCompleted];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

- (void)reloadData{
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return [goalListViewModel goalCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [goalListViewModel milestoneCountForGoalAtIndex:section];
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [goalListViewModel titleForGoalAtIndex:section];
}
 */


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    RZMilestonesHeaderCell *sectionHeaderCell = (RZMilestonesHeaderCell *)[tableView dequeueReusableCellWithIdentifier:[RZMilestonesHeaderCell defaultReuseIdentifier]];
    return [sectionHeaderCell frame].size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    RZMilestonesHeaderCell *sectionHeaderCell = (RZMilestonesHeaderCell *)[tableView dequeueReusableCellWithIdentifier:[RZMilestonesHeaderCell defaultReuseIdentifier]];
    [[sectionHeaderCell titleButton] setTitle:[goalListViewModel titleForGoalAtIndex:section] forState:UIControlStateNormal];
    [sectionHeaderCell setTableViewSectionIndex:section];
    [RZUIStyleGuide addGradientBackgroundLightToView:sectionHeaderCell.contentView];
    return sectionHeaderCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RZMilestoneCell *cell = (RZMilestoneCell *)[tableView dequeueReusableCellWithIdentifier:[RZMilestoneCell defaultReuseIdentifier] forIndexPath:indexPath];
	[cell setDelegate:self];
    
    RZMilestoneViewModel *viewModel = [goalListViewModel milestoneViewModelAtIndexPath:indexPath];

    //NOTE: should this logic be moved into the cell by passing the whole view model?
    [[cell titleLabel] setText:[viewModel title]];
    [[cell statusLabel] setText:[[viewModel status] title]];
    [[cell statusLabel] setTextColor:[[viewModel status] color]];
    BOOL isCompleted = ( [[viewModel status] status] == RZActivityStatusComplete );
    [[cell completeButton] setHidden:isCompleted];
    
    return cell;
}

- (void)milestoneCompletePressed{
    
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


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

#pragma mark - RZMilestoneEditViewControllerDelegate


- (void)milestoneEditViewControllerDidCancel:(RZMilestoneEditViewController *)controller{[[[UIAlertView alloc] initWithTitle:@"Not Implemented!" message:@"This method requires further development.  It's simply a placeholder" delegate:nil cancelButtonTitle:@"Gotcha" otherButtonTitles:nil] show];}

- (void)milestoneEditViewController:(RZMilestoneEditViewController *)controller didUpdateMilestone:(RZMilestoneViewModel *)milestone{
    
    RZGoalViewModel *goalVM = [goalListViewModel goalAtIndex:_lastSelectedSectionHeaderIndex];
    [goalVM saveMilestone:milestone];
    
    [self reloadData];
    
}

#pragma mark - RZMilestoneCellDelegate

- (void)didSelectMilestoneCell:(RZMilestoneCell *)cell{
    //NSIndexPath *path = [[self tableView] indexPathForCell:cell];
    [self performSegueWithIdentifier:@"milestoneDetailSegue" sender:self];
}

- (void)didCompleteMilestoneCell:(RZMilestoneCell *)cell{
    NSIndexPath *path = [[self tableView] indexPathForCell:cell];
    RZMilestoneViewModel *mvm = [goalListViewModel milestoneViewModelAtIndexPath:path];
    [[mvm status] setStatus:RZActivityStatusComplete];
    RZGoalViewModel *goal = [goalListViewModel goalAtIndex:path.section];
    [goal saveMilestone:mvm];
    [cell animateCompletion];
    [[cell statusLabel] setText:[[mvm status] title]];
    [[cell statusLabel] setTextColor:[[mvm status] color]];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"milestoneDetailSegue"]) {
        RZMilestoneDetailViewController *vc = (RZMilestoneDetailViewController *)[segue destinationViewController];
        NSIndexPath *selectedRowIndex = [self.tableView indexPathForSelectedRow];
        RZMilestoneViewModel *milestoneViewModel = [goalListViewModel milestoneViewModelAtIndexPath:selectedRowIndex];
        RZGoalViewModel *goalVM = [goalListViewModel goalAtIndex:selectedRowIndex.section];
        [vc setMilestoneViewModel:milestoneViewModel];
        [vc setGoalViewModel:goalVM];
    }else if ([[segue identifier] isEqualToString:@"goalDetailSegue"]) {
        RZGoalDetailViewController *vc = (RZGoalDetailViewController *)[segue destinationViewController];
        RZMilestonesHeaderCell *cell = (RZMilestonesHeaderCell *)[sender rzFirstSuperviewOfClassType:[RZMilestonesHeaderCell class]];
        
        NSInteger selectedSectionIndex = [cell tableViewSectionIndex];
        RZGoalViewModel *goalVM = [goalListViewModel goalAtIndex:selectedSectionIndex];
        [vc setGoalViewModel:goalVM];
    }else if([[segue identifier] isEqualToString:@"addMilestoneToGoalSegue"]){
        //EXAMPLE: really good application of delegate pattern using modal add view controller  http://www.raywenderlich.com/5191/beginning-storyboards-in-ios-5-part-2
        
        RZMilestonesHeaderCell *headerCell = (RZMilestonesHeaderCell *)[(UIView *)sender rzFirstSuperviewOfClassType:[RZMilestonesHeaderCell class]];
        _lastSelectedSectionHeaderIndex = [headerCell tableViewSectionIndex];
        
        RZGoalViewModel *goalVM = [goalListViewModel goalAtIndex:_lastSelectedSectionHeaderIndex];
        NSString *goalTitle = [goalVM title];
        
        RZMilestoneViewModel *milestoneVM = [[RZMilestoneViewModel alloc] initWithMilestone:nil];
        
        [milestoneVM setGoalTitle:goalTitle];
        
        //NOTE: intent is to pass needed goal title and such but the add milestone does not need any knowledge of core data!  Delegate back to this view controller.
        // Long term, complexity may be refactored out of view model, into an interacter class
        //  ViewController should contain basic iOS glue stuff; outlets, actions, etc.
        //  Presenter should contain display-specific business logic, without interacting with the models.
        //  Interactor should implement the business logic, aka use cases. It maps model data to the form needed by the Presenter and/or ViewController.
        // http://mutualmobile.github.io/blog/2013/12/04/viper-introduction/
        UINavigationController *navigationController = [segue destinationViewController];
        RZMilestoneEditViewController *destinationVC = [[navigationController viewControllers] objectAtIndex:0];
        [destinationVC setDelegate:self];
        [destinationVC setMilestoneViewModel:milestoneVM];
        
    }
    
}



@end
