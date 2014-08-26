//
//  RZSeedDataInserter.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RZCoreDataRepository.h"

@interface RZSeedDataInserter : NSObject

- (id)initWithRepository:(RZCoreDataRepository *)repos;
- (void)seedAllData;
- (void)insert2GoalsWith4and3Milestones;

@end
