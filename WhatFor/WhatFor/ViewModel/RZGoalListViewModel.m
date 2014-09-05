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
NSMutableArray *goalViewModels;


- (id)initWithRepository:(RZCoreDataRepository *)coreDataRepository hideCompletedMilestones:(BOOL)hideCompletedMilestones
{
    self = [super init];
    if (self) {
        [self setHideCompletedMilestones:hideCompletedMilestones];
        repos = coreDataRepository;
        goalViewModels = [NSMutableArray array];
        [self populateFromGoalArray:[repos getAllGoals]];
    }
    return self;
}


- (void)populateFromGoalArray:(NSArray *)goalArray{
    goals = goalArray;
    for (Goal *goal in goals)
    {
        RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
        [goalViewModels addObject:goalVM];
    }
}


#pragma mark - TableView Methods

- (NSInteger)goalCount{
    return [goalViewModels count];
}


- (RZGoalViewModel *)goalAtIndex:(NSInteger)index{
    return [goalViewModels objectAtIndex:index];
}

- (NSInteger)milestoneCountForGoalAtIndex:(NSInteger)index{
    
    RZGoalViewModel *goalVM = [goalViewModels objectAtIndex:index];
    if([self hideCompletedMilestones]){ return [[goalVM remainingMilestones] count]; }
    return [[goalVM milestones] count];
}

- (NSString *)titleForGoalAtIndex:(NSInteger)index{
    Goal *goal =[goals objectAtIndex:index];
    return [goal title];
}

- (RZMilestoneViewModel *)milestoneViewModelAtIndexPath:(NSIndexPath *)indexPath{
    
    RZGoalViewModel *goalVM = [goalViewModels objectAtIndex:indexPath.section];
    RZMilestoneViewModel *milestoneVM = ([self hideCompletedMilestones]) ? [[goalVM remainingMilestones] objectAtIndex:indexPath.row] : [[goalVM milestones] objectAtIndex:indexPath.row];
    return milestoneVM;
                                     
}


@end
