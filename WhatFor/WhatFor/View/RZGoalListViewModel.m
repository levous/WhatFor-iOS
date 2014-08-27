//
//  RZGoalListViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalListViewModel.h"
#import "Milestone+Enums.h"
#import "RZUIStyleGuide.h"

@implementation RZGoalListViewModel

RZCoreDataRepository *repos;
NSArray *goals;
NSMutableDictionary *filteredMilstones;

- (id)initWithRepository:(RZCoreDataRepository *)coreDataRepository hideCompletedMilestones:(BOOL)hideCompletedMilestones
{
    self = [super init];
    if (self) {
        [self setHideCompletedMilestones:hideCompletedMilestones];
        repos = coreDataRepository;
        goals = [repos getAllGoals];
        [self prepareFilteredMilstones];
    }
    return self;
}

- (void)prepareFilteredMilstones{
    filteredMilstones = [NSMutableDictionary dictionary];
    for (Goal *goal in goals) {
        NSMutableArray *milestones = [NSMutableArray array];
        for (Milestone *milestone in [goal goalMilestones]) {
            if(![self hideCompletedMilestones] || ([milestone status] != RZActivityStatusComplete))
            {
                [milestones addObject:milestone];
            }
        }
        [filteredMilstones setObject:milestones forKey:[goal objectID]];
    }
}

#pragma mark - View Logic

- (NSString *)textForStatus:(RZActivityStatus)status{
    switch (status){
    
    case RZActivityStatusInProgress:
        return @"In Progress";
        break;
    case RZActivityStatusComplete:
        return @"Completed";
        break;
    case RZActivityStatusBlocked:
        return @"Blocked";
        break;
    default:
        return @"Unknown";
        break;
    }
}

#pragma mark - TableView Methods

- (NSUInteger)goalCount{
    return [goals count];
}

- (NSUInteger)milestoneCountForGoalAtIndex:(NSUInteger)index{
    
    Goal *goal = [goals objectAtIndex:index];
    NSArray *milestones = [filteredMilstones objectForKey:[goal objectID]];
    if(milestones == nil) return 0;
    return [milestones count];
}

- (NSString *)titleForGoalAtIndex:(NSUInteger)index{
    Goal *goal =[goals objectAtIndex:index];
    return [goal title];
}

- (RZMilestoneViewModel *)milestoneViewModelAtIndexPath:(NSIndexPath *)indexPath{
    
    Goal *goal = [goals objectAtIndex:indexPath.section];
    NSArray *milestones = [filteredMilstones objectForKey:[goal objectID]];
    Milestone *milestone = [milestones objectAtIndex:indexPath.row];
    RZMilestoneViewModel *viewModel = [[RZMilestoneViewModel alloc] init];
    [viewModel setTitle:[milestone title]];
    [viewModel setSummary:[milestone summary]];
    RZActivityStatus status = [milestone status];
    [[viewModel status] setTitle:[self textForStatus:status]];
    [[viewModel status] setColor:[RZUIStyleGuide fontColorForStatus:status]];

    return viewModel;
                                     
}


@end
