//
//  MilestoneViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "MilestoneViewModel.h"
@implementation MilestoneViewModelStatus
@synthesize title, color;
@end

@implementation MilestoneViewModel
@synthesize title, summary, status;
- (id)init
{
    self = [super init];
    if (self) {
        status = [[MilestoneViewModelStatus alloc] init];
    }
    return self;
}
@end
