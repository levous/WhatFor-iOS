//
//  Milestone.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goal;

@interface Milestone : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) Goal *milestoneGoal;

@end
