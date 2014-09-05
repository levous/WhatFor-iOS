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
                                        initWithKey:@"dateDue" ascending:YES];
    
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
    
    // handle db upgrade
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    //NOTE: auto upgrade annoying me during development!  disable
    options = nil;
    
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[RZCoreDataRepository managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
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
        switch ([error code]){
            case 134100:
                // this is a model incompatibility issue and we need to blow away the data
                NSLog(@"DESTROYING THE DATABASE BECAUSE THE MODEL APPEARS TO HAVE CHANGED\nidentified error: %@, %@", error, [error userInfo]);
                [self clearAllData];
                // it might still crash... but it'll start next run.  Let's try to set up the persistent store again.  This is a development solution, not an appropriate consumer practice.  In that case, we need to version appropriately
                if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
                    NSLog(@"Tried to blow away the database and recreate the persistent store but... Unresolved error %@, %@", error, [error userInfo]);
                    abort();
                }
                break;
            case 134130:
                NSLog(@"LOOKS LIKE YOU FORGOT TO VERSION THE DATAMODEL CHANGE!!!! (in xcode data model) \nidentified error: %@, %@", error, [error userInfo]);
                abort();
                break;
                
            default:
            
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
                abort();
                break;
        
        }
    }
    
    return _persistentStoreCoordinator;
}

- (void)clearAllData{
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"WhatFor.sqlite"];
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
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
