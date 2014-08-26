//
//  RZSeedDataInserter.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZSeedDataInserter.h"

@implementation RZSeedDataInserter

RZCoreDataRepository *_repos;

- (id)initWithRepository:(RZCoreDataRepository *)repos
{
    self = [self init];
    if (self) {
        _repos = repos;
    }
    return self;
}

- (void)insert2Goals{

    Goal *goal = _repos.createGoal;
    [goal setTitle:@"Goal 1"];
    
    Milestone *milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.1"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.2"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.3"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.4"];

    goal = _repos.createGoal;
    [goal setTitle:@"Goal 2"];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.1"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.2"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.3"];
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.4"];


    
}

@end
