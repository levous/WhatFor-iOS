//
//  RZMilestoneDetailViewController.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZMilestoneViewModel.h"

@interface RZMilestoneDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *summaryTextView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateDueLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeRemainingLabel;
@property (strong, nonatomic) RZMilestoneViewModel *milestoneViewModel;

@end
