//
//  RZCoreDataRepository.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZCoreDataRepository.h"

@implementation RZCoreDataRepository

@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)aManagedObjectContext{
    self = [super init];
    if (self) {
        _managedObjectContext = aManagedObjectContext;

    }
    return self;
}

#pragma mark - Generic Helpers

- (id)createEntityWithName:(NSString *)entityName{
    NSManagedObject *mo = [NSEntityDescription
                             insertNewObjectForEntityForName:entityName
                             inManagedObjectContext:self.managedObjectContext];
    
    NSDictionary *attributes = [[mo entity] attributesByName];
    
    // set createDate if present
    
    if([attributes objectForKey:@"createDate"] != nil){
        [mo setValue:[NSDate date] forKey:@"createDate"];
    }
    
    
    return mo;

}

- (NSFetchRequest *)fetchRequestForEntityNamed:(NSString *)entityName{
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    return request;
}

#pragma mark - Goals

- (Goal *)createGoal{
        return [self createEntityWithName:@"Goal"];
}

- (NSArray *)getAllGoals{
    
    NSFetchRequest *request = [self fetchRequestForEntityNamed:@"Goal"];
    NSSortDescriptor *sortDesc = [NSSortDescriptor sortDescriptorWithKey:@"sortOrder" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDesc, nil]];
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    return array;
}



#pragma mark - Milestones

- (Milestone *)createMilestoneForGoal:(Goal *)goal{
    Milestone *milestone = [self createEntityWithName:@"Milestone"];
    [milestone setMilestoneGoal:goal];
    return milestone;
}



- (NSArray *)getAllMilestones{
    
   
    NSFetchRequest *request = [self fetchRequestForEntityNamed:@"Goal"];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
                                        initWithKey:@"dueDate" ascending:YES];
    
    [request setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *array = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (array == nil)
    {
        // Deal with error...
    }
    return array;
    
}


#pragma mark - Core Data stack

// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}

// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
+ (NSManagedObjectModel *)managedObjectModel
{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"WhatFor" withExtension:@"momd"];
    return [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
}

// Returns the persistent store coordinator for the application.
// If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WhatFor.sqlite"];
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[RZCoreDataRepository managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}


@end
