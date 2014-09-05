//
//  Milestone.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/5/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Goal;

@interface Milestone : NSManagedObject

@property (nonatomic, retain) NSDate * dateCreated;
@property (nonatomic, retain) NSDate * dateDue;
@property (nonatomic, retain) NSNumber * pointValue;
@property (nonatomic, retain) NSNumber * statusNumber;
@property (nonatomic, retain) NSString * summary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Goal *milestoneGoal;

@end
