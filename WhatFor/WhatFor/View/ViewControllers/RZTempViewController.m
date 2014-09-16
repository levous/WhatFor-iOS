//
//  RZTempViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZTempViewController.h"
#import "RZAppDelegate.h"
#import "RZCoreDataRepository.h"
#import "RZGoalListViewController.h"

@interface RZTempViewController ()

@end

@implementation RZTempViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RZGoalEditViewControllerDelegate

- (void)goalEditViewControllerDidCancel:(RZGoalEditViewController *)controller{
    
}
- (void)goalEditViewController:(RZGoalEditViewController *)controller didUpdateGoal:(RZGoalViewModel *)goal{
    [goal save];
}

#pragma  mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //TODO: make this code less strinky.  ie: no app delegate nonsense
    RZAppDelegate *appDelegate = (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
    RZCoreDataRepository *repos = [appDelegate coreDataRepository];

    
    if ([[segue identifier] isEqualToString:@"allMilestonesSegue"]) {
        RZGoalListViewController *vc = (RZGoalListViewController *)[segue destinationViewController];
        [vc setHideCompleted:NO];
        [vc setCoreDataRepository:repos];
    }else if([[segue identifier] isEqualToString:@"incompleteMilestonesSegue"]){
        RZGoalListViewController *vc = (RZGoalListViewController *)[segue destinationViewController];
        [vc setHideCompleted:YES];
        [vc setCoreDataRepository:repos];
    }else if([[segue identifier] isEqualToString:@"addGoalSegue"]){
      
        RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:nil andRepository:repos];
        UINavigationController *navigationController = [segue destinationViewController];
        RZGoalEditViewController *destinationVC = [[navigationController viewControllers] objectAtIndex:0];
        [destinationVC setDelegate:self];
        [destinationVC setGoalViewModel:goalVM];
        
    }
}

@end
