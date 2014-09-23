//
//  RZGoalListViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCoreDataRepository.h"
#import "RZMilestoneEditViewController.h"
#import "RZMilestoneCell.h"
#import "RZGoalMilestonesListHeaderView.h"


@interface RZGoalListViewController : UITableViewController<RZMilestoneEditViewControllerDelegate,RZMilestoneCellDelegate,RZGoalMilestonesListHeaderViewDelegate>{
    NSInteger _lastSelectedSectionHeaderIndex;
}

@property (strong, nonatomic) RZCoreDataRepository *coreDataRepository;
@property (nonatomic) BOOL hideCompleted;

@end
