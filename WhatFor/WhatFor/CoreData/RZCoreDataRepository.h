//
//  RZCoreDataRepository.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ModelHeader.h"

@interface RZCoreDataRepository : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (NSManagedObjectModel *) managedObjectModel;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext;

#pragma mark - Goals
- (Goal *)createGoal;
- (NSArray *)getAllGoals;

#pragma mark - Milestones
- (Milestone *)createMilestoneForGoal:(Goal *)goal;

#pragma mark - clear all
- (void)clearAllData;

#pragma mark - save
- (void)saveContext;
@end
