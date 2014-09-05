//
//  RZGoalDetailViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalDetailViewController.h"
#import "RZMilestoneDetailViewController.h"
#import "UIView+QuartzEffects.h"

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
    
    [[cell titleLabel] setText:[viewModel title]];
    [[cell statusLabel] setText:[[viewModel status] title]];
    [[cell statusLabel] setTextColor:[[viewModel status] color]];
    
    if ([[viewModel status] status] == RZActivityStatusBlocked) {
        [[cell contentView] flashElipseWithColor:[[viewModel status] color]];
    }
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

#pragma mark - RZMilestoneCellDelegate

- (void)didSelectMilestoneCell:(RZMilestoneCell *)cell{
    //NSIndexPath *path = [[self tableView] indexPathForCell:cell];
    [self performSegueWithIdentifier:@"milestoneDetailSegue" sender:self];
}

#pragma mark - Storyboard Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"milestoneDetailSegue"]) {
        RZMilestoneDetailViewController *vc = (RZMilestoneDetailViewController *)[segue destinationViewController];
        NSIndexPath *selectedRowIndex = [[self tableView] indexPathForSelectedRow];
        RZMilestoneViewModel *milestoneViewModel = [[[self goalViewModel] milestones] objectAtIndex:selectedRowIndex.row];
        [vc setMilestoneViewModel:milestoneViewModel];
    }
}
#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
