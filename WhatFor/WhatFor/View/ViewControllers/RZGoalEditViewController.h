//
//  RZMilestoneAddViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZGoalViewModel.h"
@class RZGoalEditViewController;

@protocol RZGoalEditViewControllerDelegate
- (void)goalEditViewControllerDidCancel:(RZGoalEditViewController *)controller;
- (void)goalEditViewController:(RZGoalEditViewController *)controller didUpdateGoal:(RZGoalViewModel *)goal;
@end

@interface RZGoalEditViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (nonatomic, strong) RZGoalViewModel *goalViewModel;
@property (nonatomic, weak) id<RZGoalEditViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
