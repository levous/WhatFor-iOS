//
//  Goal.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/5/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Milestone;

@interface Goal : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSNumber * sortOrder;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSOrderedSet *goalMilestones;
@end

@interface Goal (CoreDataGeneratedAccessors)

- (void)insertObject:(Milestone *)value inGoalMilestonesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromGoalMilestonesAtIndex:(NSUInteger)idx;
- (void)insertGoalMilestones:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeGoalMilestonesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInGoalMilestonesAtIndex:(NSUInteger)idx withObject:(Milestone *)value;
- (void)replaceGoalMilestonesAtIndexes:(NSIndexSet *)indexes withGoalMilestones:(NSArray *)values;
- (void)addGoalMilestonesObject:(Milestone *)value;
- (void)removeGoalMilestonesObject:(Milestone *)value;
- (void)addGoalMilestones:(NSOrderedSet *)values;
- (void)removeGoalMilestones:(NSOrderedSet *)values;
@end
