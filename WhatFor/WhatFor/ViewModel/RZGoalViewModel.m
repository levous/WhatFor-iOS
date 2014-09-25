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

- (id)initWithGoal:(Goal *)goal andRepository:(RZCoreDataRepository *)repository
{
    self = [super init];
    if (self) {
        _goal = goal;
        _repository = repository;
        [self setStatus:[[RZStatusViewModel alloc] init]];
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
    [self computeGoalStatus];
}

- (void)computeGoalStatus{
    RZActivityStatus tempStatus = RZActivityStatusComplete;
    bool allComplete = YES;
    for(RZMilestoneViewModel *m in [self milestones]){
        switch ([[m status] status]){
            case RZActivityStatusBlocked:
                // blocked milestone blocks goal
                tempStatus = RZActivityStatusBlocked;
                allComplete = NO;
                break;
            
            case RZActivityStatusInProgress:
                // in progress milestone, goal in progress
                tempStatus = RZActivityStatusInProgress;
                allComplete = NO;
                break;
            case RZActivityStatusNotStarted:
                // not started milestone, goal may be in progress or not started
                if (tempStatus != RZActivityStatusInProgress) {
                    tempStatus = RZActivityStatusNotStarted;
                }
                allComplete = NO;
                break;
            default: // RZActivityStatusComplete
                if (allComplete)
                {
                    // redundant to set but clearer intent
                    tempStatus = RZActivityStatusComplete;
                }
                else
                {
                    tempStatus = RZActivityStatusInProgress;
                }
                break;
        }
        
        if (tempStatus == RZActivityStatusBlocked) {
            break; // exit for
        }
    }
    
    [[self status] setStatus:tempStatus];
    
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

- (id)refreshedCopy{
    RZGoalViewModel *copyVM = [[RZGoalViewModel alloc] initWithGoal:_goal andRepository:_repository];
    return copyVM;
}

- (void)saveMilestone:(RZMilestoneViewModel *)milestoneViewModel{
    Milestone *milestone = [milestoneViewModel milestone];
    if (milestone == nil)
    {
        milestone = [_repository createMilestoneForGoal:_goal];
        [milestoneViewModel setMilestone:milestone];
    }
    else if(![[_goal goalMilestones] containsObject:milestone])
    {
        [_goal addGoalMilestonesObject:milestone];
    }
    
    [milestoneViewModel updateMilestoneFromViewModel];
    [_repository saveContext];
    
}

- (void)updateGoalFromViewModel{
    [_goal setTitle:[self title]];
    [_goal setSummary:[self summary]];
      
}

- (void)save{
    if (_goal == nil)
    {
        _goal = [_repository createGoal];
    }
    [self updateGoalFromViewModel];
    [_repository saveContext];
}

@end
