//
//  RZTestingRepository.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZTestingRepository.h"

@implementation RZTestingRepository

- (id)init
{

    self = [super initWithManagedObjectContext:[RZTestingRepository createInMemoryMangedObjectContext]];
    if (self) {
        // nothing more to do...
    }
    return self;
}

+ (NSManagedObjectContext *)createInMemoryMangedObjectContext{
    // ObjectModel from any models in app bundle
    NSManagedObjectModel *managedObjectModel = [RZCoreDataRepository managedObjectModel];
    
    // Coordinator with in-mem store type
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    [coordinator addPersistentStoreWithType:NSInMemoryStoreType configuration:nil URL:nil options:nil error:nil];
    
    // Context with private queue
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType]; // Choose your concurrency type, or leave it off entirely
    context.persistentStoreCoordinator = coordinator;
    return context;
}

@end
