//
//  RZGoalMilestonesListHeaderView.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/28/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RZGoalMilestonesListHeaderView;

@protocol RZGoalMilestonesListHeaderViewDelegate
- (void)rzGoalMilestonesListHeaderView:(RZGoalMilestonesListHeaderView *)headerView didTapGoalTitle:(id)sender;
- (void)rzGoalMilestonesListHeaderView:(RZGoalMilestonesListHeaderView *)headerView didTapAddMilestone:(id)sender;
@end

@interface RZGoalMilestonesListHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) IBOutlet UIButton *titleButton;
@property (nonatomic) NSInteger tableViewSectionIndex;
@property (nonatomic) id<RZGoalMilestonesListHeaderViewDelegate> delegate;

+ (NSString *)defaultReuseIdentifier;
+ (NSString *)defaultNibName;

@end

