//
//  RZMilestoneCell.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RZMilestoneCell;

@protocol RZMilestoneCellDelegate
- (void)didSelectMilestoneCell:(RZMilestoneCell *)cell;
- (void)didCompleteMilestoneCell:(RZMilestoneCell *)cell;
@end

@interface RZMilestoneCell : UITableViewCell
@property (nonatomic) id<RZMilestoneCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
+ (NSString *)defaultReuseIdentifier;
- (void)animateCompletion;
@end
