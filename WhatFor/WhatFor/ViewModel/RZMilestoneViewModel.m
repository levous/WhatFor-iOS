//
//  MilestoneViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneViewModel.h"

#import "NSDateFormatter+RZSharedDateFormatters.h"
#import "RZUIStyleGuide.h"
#import "RZStringsHelper.h"
#import "Goal.h"

@implementation RZMilestoneViewModelStatus

- (void)setStatus:(RZActivityStatus)status {
    _status = status;
    _title = [RZStringsHelper titleForActivityStatus:status];
    _color = [RZUIStyleGuide fontColorForStatus:status];
}

- (RZActivityStatus) status{
    return _status;
}

@end

@implementation RZMilestoneViewModel

- (id)init{
    self = [super init];
    if (self) {
        [self setStatus:[[RZMilestoneViewModelStatus alloc] init]];
    }
    return self;
}

- (id)initWithMilestone:(Milestone *)milestone
{
    self = [self init];
    if (self) {
        [self setStatus:[[RZMilestoneViewModelStatus alloc] init]];
        [self populateFromMilestone:milestone];
    }
    return self;
}

#pragma mark - View Logic

- (NSString *)textForStatus:(RZActivityStatus)status{
    return [RZStringsHelper titleForActivityStatus:status];
}

- (void)populateFromMilestone:(Milestone *)milestone{
    _milestone = milestone;
    [self setTitle:[milestone title]];
    [self setSummary:[milestone summary]];
    if ([milestone dueDate] == nil) {
        [self setDateDue:@"no due date"];
    }else{
        [self setDateDue:[NSDateFormatter shortStringFromDate:[milestone dueDate]]];
    }
    
    [self setTimeRemaining:@""]; //lazy today.  maybe later
    RZActivityStatus status = [milestone status];
    [[self status] setStatus:status];
    
    [self setGoalTitle:[[milestone milestoneGoal] title]];
}

@end
