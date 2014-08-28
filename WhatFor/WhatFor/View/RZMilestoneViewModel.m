//
//  MilestoneViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneViewModel.h"
#import "RZUIStyleGuide.h"
#import "NSDateFormatter+RZSharedDateFormatters.h"

@implementation RZMilestoneViewModelStatus
@synthesize title, color;
@end

@implementation RZMilestoneViewModel

- (id)initWithMilestone:(Milestone *)milestone
{
    self = [super init];
    if (self) {
        [self setStatus:[[RZMilestoneViewModelStatus alloc] init]];
        [self populateFromMilestone:milestone];
    }
    return self;
}

#pragma mark - View Logic

- (NSString *)textForStatus:(RZActivityStatus)status{
    switch (status){
            
        case RZActivityStatusInProgress:
            return @"In Progress";
            break;
        case RZActivityStatusComplete:
            return @"Completed";
            break;
        case RZActivityStatusBlocked:
            return @"Blocked";
            break;
        default:
            return @"Not Started";
            break;
    }
}

- (void)populateFromMilestone:(Milestone *)milestone{
    [self setMilestone:milestone];
    [self setTitle:[milestone title]];
    [self setSummary:[milestone summary]];
    if ([milestone dueDate] == nil) {
        [self setDateDue:@"no due date"];
    }else{
        [self setDateDue:[NSDateFormatter shortStringFromDate:[milestone dueDate]]];
    }
    
    [self setTimeRemaining:@""]; //lazy today.  maybe later
    RZActivityStatus status = [milestone status];
    [[self status] setTitle:[self textForStatus:status]];
    [[self status] setColor:[RZUIStyleGuide fontColorForStatus:status]];
}

@end
