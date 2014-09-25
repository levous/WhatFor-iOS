//
//  RZMilestoneCell.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RZMilestoneCell;
@class RZMilestoneViewModel;

@protocol RZMilestoneCellDelegate
- (void)didSelectMilestoneCell:(RZMilestoneCell *)cell;
- (void)rzMilestoneCell:(id)milestoneCell didUpdateStatusOnMilestone:(RZMilestoneViewModel *)milestoneViewModel;
@end

@interface RZMilestoneCell : UITableViewCell{
    RZMilestoneViewModel *_milestoneViewModel;
}

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;
@property (weak, nonatomic) IBOutlet UIImageView *completeIconImage;

@property (nonatomic) id<RZMilestoneCellDelegate> delegate;
@property (weak, nonatomic) RZMilestoneViewModel *milestoneViewModel;


+ (NSString *)defaultReuseIdentifier;
+ (NSString *)defaultNibName;
- (void)animateTransitionToCurrentStatus;
@end
