//
//  RZGoalMilestonesListHeaderView.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/28/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalMilestonesListHeaderView.h"

@implementation RZGoalMilestonesListHeaderView

+ (NSString *)defaultReuseIdentifier{ return @"milestonesHeaderCell"; }
+ (NSString *)defaultNibName{ return @"GoalMilestonesListHeaderView"; }


- (IBAction)titleTapped:(id)sender {
    if([self delegate] != nil){
        [[self delegate] rzGoalMilestonesListHeaderView:self didTapGoalTitle:sender];
    }
}

- (IBAction)addMilestoneTapped:(id)sender {
    if([self delegate] != nil){
        [[self delegate] rzGoalMilestonesListHeaderView:self didTapAddMilestone:sender];
    }
}

@end
