//
//  RZMilestoneDetailViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneDetailViewController.h"
#import "RZMilestoneEditViewController.h"

@interface RZMilestoneDetailViewController ()

@end

@implementation RZMilestoneDetailViewController

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
    [self refreshData];
    
}

- (void)refreshData{
    [[self titleLabel] setText:[[self milestoneViewModel] title]];
    [[self summaryTextView] setText:[[self milestoneViewModel] summary]];
    [[self statusLabel] setText:[[[self milestoneViewModel] status] title]];
    [[self statusLabel] setTextColor:[[[self milestoneViewModel] status] color]];
    [[self dateDueLabel] setText:[[self milestoneViewModel] dateDueText]];
    [[self timeRemainingLabel] setText:[[self milestoneViewModel] timeRemaining]];
}

#pragma mark - RZMilestoneEditViewControllerDelegate


- (void)milestoneEditViewControllerDidCancel:(RZMilestoneEditViewController *)controller{[[[UIAlertView alloc] initWithTitle:@"Not Implemented!" message:@"This method requires further development.  It's simply a placeholder" delegate:nil cancelButtonTitle:@"Gotcha" otherButtonTitles:nil] show];}

- (void)milestoneEditViewController:(RZMilestoneEditViewController *)controller didUpdateMilestone:(RZMilestoneViewModel *)milestone{
    [[self goalViewModel] saveMilestone:milestone];
    
    [self refreshData];
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier] isEqualToString:@"editMilestoneSegue"]){
        
        UINavigationController *navigationController = [segue destinationViewController];
        RZMilestoneEditViewController *destinationVC = [[navigationController viewControllers] objectAtIndex:0];
        [destinationVC setDelegate:(id<RZMilestoneEditViewControllerDelegate>)self];
        [destinationVC setMilestoneViewModel:[self milestoneViewModel]];
        [destinationVC setTitle:@"Edit Milestone"];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
