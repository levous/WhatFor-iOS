//
//  RZGoalListViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalListViewModel.h"

@implementation RZGoalListViewModel

RZCoreDataRepository *repos;
NSArray *goals;

- (id)initWithRepository:(RZCoreDataRepository *)coreDataRepository
{
    self = [super init];
    if (self) {
        repos = coreDataRepository;
        goals = [repos getAllGoals];
    }
    return self;
}

- (NSUInteger)goalCount{
    return [goals count];
}

- (NSUInteger)milestoneCountForGoalAtIndex:(NSUInteger)index{
    Goal *goal = [goals objectAtIndex:index];
    return [[goal goalMilestones] count];
}

- (NSString *)titleForGoalAtIndex:(NSUInteger)index{
    Goal *goal =[goals objectAtIndex:index];
    return [goal title];
}

- (MilestoneViewModel *)milestoneViewModelAtIndexPath:(NSIndexPath *)indexPath{
    

    Milestone *milestone = [[[goals objectAtIndex:indexPath.section] goalMilestones] objectAtIndex:indexPath.row];
    MilestoneViewModel *viewModel = [[MilestoneViewModel alloc] init];
    [viewModel setTitle:[milestone title]];
    [viewModel setSummary:[milestone summary]];
    [[viewModel status] setTitle:@"Completed"];
    [[viewModel status] setColor:[UIColor greenColor]];

    return viewModel;
                                     
}


@end
