//
//  RZGoalViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/2/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Goal;
#import "RZMilestoneViewModel.h"
#import "RZStatusViewModel.h"
#import "RZCoreDataRepository.h"

@interface RZGoalViewModel : NSObject{
    Goal *_goal;
    RZCoreDataRepository *_repository;
}

@property (strong, nonatomic) RZStatusViewModel *status;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSArray *milestones;
@property (nonatomic, strong) NSArray *remainingMilestones;

- (id)initWithGoal:(Goal *)goal andRepository:(RZCoreDataRepository *)repository;
- (void)saveMilestone:(RZMilestoneViewModel *)milestoneViewModel;
- (void)save;

@end
