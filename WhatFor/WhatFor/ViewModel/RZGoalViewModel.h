//
//  RZGoalViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 9/2/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Goal;
#import "RZMilestoneViewModel.h"


@interface RZGoalViewModel : NSObject{
    Goal *_goal;
}

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSArray *milestones;
@property (nonatomic, strong) NSArray *remainingMilestones;

- (id)initWithGoal:(Goal *)goal;
@end
