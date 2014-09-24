//
//  RZGoalDetailViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZGoalViewModel.h"
#import "RZMilestoneCell.h"
#import "RZMilestoneEditViewController.h"
#import "RZMilestoneDetailViewController.h"

@protocol RZGoalDetailViewControllerDelegate
- (void)rzGoalDetailViewController:(id)viewController goalDataDidChange:(RZGoalViewModel *)goalViewModel;
@end

@interface RZGoalDetailViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RZMilestoneCellDelegate, RZMilestoneEditViewControllerDelegate,RZMilestoneDetailViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic)  id<RZGoalDetailViewControllerDelegate> delegate;

@property (strong, nonatomic) RZGoalViewModel *goalViewModel;

@end
