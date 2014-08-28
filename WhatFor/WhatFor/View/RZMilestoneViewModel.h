//
//  MilestoneViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Milestone.h"
#import "Milestone+Enums.h"

@interface RZMilestoneViewModelStatus : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *color;
@end

@interface RZMilestoneViewModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *dateDue;
@property (strong, nonatomic) NSString *timeRemaining;

@property (strong, nonatomic) RZMilestoneViewModelStatus *status;
@property (strong, nonatomic) Milestone *milestone;


- (id)initWithMilestone:(Milestone *)milestone;
@end
