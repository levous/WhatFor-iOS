//
//  RZGoalListViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZCoreDataRepository.h"
#import "RZMilestoneViewModel.h"
@interface RZGoalListViewModel : NSObject

@property(nonatomic) BOOL hideCompletedMilestones;

- (id)initWithRepository:(RZCoreDataRepository *)coreDataRepository hideCompletedMilestones:(BOOL)hideCompletedMilestones;
- (NSUInteger)goalCount;
- (NSUInteger)milestoneCountForGoalAtIndex:(NSUInteger)index;
- (NSString *)titleForGoalAtIndex:(NSUInteger)index;
- (RZMilestoneViewModel *)milestoneViewModelAtIndexPath:(NSIndexPath *)indexPath;


@end
