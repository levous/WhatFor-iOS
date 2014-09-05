//
//  RZMilestoneAddViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZMilestoneViewModel.h"
#import "RZStatusViewModel.h"
#import "RZStatusViewModel.h"
#import "RZActivityStatusPickerViewController.h"
@class RZMilestoneAddViewController;

@protocol RZMilestoneAddViewControllerDelegate
- (void)milestoneAddViewControllerDidCancel:(RZMilestoneAddViewController *)controller;
- (void)milestoneAddViewController:(RZMilestoneAddViewController *)controller didUpdateMilestone:(RZMilestoneViewModel *)milestone;
@end

@interface RZMilestoneAddViewController : UITableViewController<RZActivityStatusPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *goalTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UITextField *dueDateTextField;
@property (weak, nonatomic) IBOutlet UITableViewCell *statusTableCell;
@property (weak, nonatomic) IBOutlet UITextField *pointValueTextField;
@property (nonatomic, strong) RZMilestoneViewModel *milestoneViewModel;
@property (nonatomic, strong) RZStatusViewModel *statusViewModel;
@property (nonatomic, weak) id<RZMilestoneAddViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;
@end
