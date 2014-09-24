//
//  RZGoalListViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCoreDataRepository.h"
#import "RZMilestoneDetailViewController.h"
#import "RZMilestoneEditViewController.h"
#import "RZGoalDetailViewController.h"
#import "RZMilestoneCell.h"
#import "RZGoalMilestonesListHeaderView.h"


@interface RZGoalListViewController : UITableViewController<RZMilestoneCellDelegate, RZGoalMilestonesListHeaderViewDelegate, RZGoalDetailViewControllerDelegate, RZMilestoneEditViewControllerDelegate, RZMilestoneDetailViewControllerDelegate>{
    NSInteger _lastSelectedSectionHeaderIndex;
}

@property (strong, nonatomic) RZCoreDataRepository *coreDataRepository;
@property (nonatomic) BOOL hideCompleted;

@end
