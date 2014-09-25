//
//  MilestoneViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneViewModel.h"

#import "NSDateFormatter+RZSharedDateFormatters.h"

#import "Goal.h"



@implementation RZMilestoneViewModel

- (id)init{
    self = [super init];
    if (self) {
        [self setStatus:[[RZStatusViewModel alloc] init]];
    }
    return self;
}

- (id)initWithMilestone:(Milestone *)milestone
{
    self = [self init];
    if (self) {
        [self populateFromMilestone:milestone];
    }
    return self;
}

#pragma mark - View Logic


- (void)populateFromMilestone:(Milestone *)milestone{
    [self setMilestone:milestone];
    [self setTitle:[milestone title]];
    [self setSummary:[milestone summary]];
    [self setDateDue:[milestone dateDue]];
    if ([milestone dateDue] == nil) {
        [self setDateDueText:@"no due date"];
    }else{
        [self setDateDueText:[NSDateFormatter shortStringFromDate:[milestone dateDue]]];
    }
    
    [self setTimeRemaining:@""]; //lazy today.  maybe later
    
    // if milestone is nil, then status will interpret as 0:Blocked  ...just sayin'
    RZActivityStatus status = [milestone status];
    [[self status] setStatus:status];
    
    [self setGoalTitle:[[milestone milestoneGoal] title]];
}

- (void)updateMilestoneFromViewModel{
    [[self milestone] setTitle:[self title]];
    [[self milestone] setSummary:[self summary]];
    [[self milestone] setStatus:[[self status] status]];
    [[self milestone] setDateDue:[self dateDue]];
    
}

- (void)promoteToNextStatus{
    RZActivityStatus status = [[self status] status];
    if (status < RZActivityStatusComplete) {
        [[self status] setStatus:++status];
    }
}


@end
