//
//  RZStringsHelper.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/1/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZStringsHelper.h"


@implementation RZStringsHelper
+ (NSString *)titleForActivityStatus:(RZActivityStatus)status{
    switch (status) {
        case RZActivityStatusInProgress:
            return @"In Progress";
        case RZActivityStatusComplete:
            return @"Completed";
        case RZActivityStatusBlocked:
            return @"Blocked";
        default:
            return @"Not Started";
    }
}

@end
