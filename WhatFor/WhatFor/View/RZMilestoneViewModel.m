//
//  MilestoneViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneViewModel.h"
@implementation RZMilestoneViewModelStatus
@synthesize title, color;
@end

@implementation RZMilestoneViewModel
@synthesize title, summary, status;
- (id)init
{
    self = [super init];
    if (self) {
        status = [[RZMilestoneViewModelStatus alloc] init];
    }
    return self;
}
@end
