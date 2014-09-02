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
@end

@interface RZMilestoneCell : UITableViewCell
@property (nonatomic) id<RZMilestoneCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
+ (NSString *)defaultReuseIdentifier;
@end
