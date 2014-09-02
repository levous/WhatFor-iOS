//
//  RZGoalViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/2/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalViewModel.h"
#import "Goal.h"

@implementation RZGoalViewModel

- (id)initWithGoal:(Goal *)goal
{
    self = [super init];
    if (self) {
        _goal = goal;
        [self populateFromGoal:goal];
    }
    return self;
}

- (void)populateFromGoal:(Goal *)goal{
    
    [self setTitle:[goal title]];
    [self setSummary:[goal summary]];
    
    NSMutableArray *tempMilestones = [NSMutableArray array];
    for (Milestone *milestone in [goal goalMilestones]) {
        RZMilestoneViewModel *milestoneVM = [[RZMilestoneViewModel alloc] initWithMilestone:milestone];
        [tempMilestones addObject:milestoneVM];
    }
    [self setMilestones:[NSArray arrayWithArray:tempMilestones]];
    [self prepareFilteredMilstones];
}

- (void)prepareFilteredMilstones{
    NSMutableArray *filteredMilstones = [NSMutableArray array];
    for (RZMilestoneViewModel *milestone in [self milestones]) {
        if([[milestone status] status] != RZActivityStatusComplete)
        {
            [filteredMilstones addObject:milestone];
        }
    }
    [self setRemainingMilestones:[NSArray arrayWithArray:filteredMilstones]];
}
@end
