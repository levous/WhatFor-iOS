//
//  RZGoalListViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZCoreDataRepository.h"
#import "RZMilestoneAddViewController.h"
#import "RZMilestoneCell.h"


@interface RZGoalListViewController : UITableViewController<RZMilestoneAddViewControllerDelegate,RZMilestoneCellDelegate>

@property (strong, nonatomic) RZCoreDataRepository *coreDataRepository;
@property (nonatomic) BOOL hideCompleted;
@end
