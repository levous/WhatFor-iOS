//
//  RZGoalListViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZCoreDataRepository.h"
#import "MilestoneViewModel.h"
@interface RZGoalListViewModel : NSObject

- (id)initWithRepository:(RZCoreDataRepository *)coreDataRepository;
- (NSUInteger)goalCount;
- (NSUInteger)milestoneCountForGoalAtIndex:(NSUInteger)index;
- (NSString *)titleForGoalAtIndex:(NSUInteger)index;
- (MilestoneViewModel *)milestoneViewModelAtIndexPath:(NSIndexPath *)indexPath;

@end
