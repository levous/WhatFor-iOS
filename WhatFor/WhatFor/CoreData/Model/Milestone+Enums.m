//
//  Milestone+Enums.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "Milestone+Enums.h"

@implementation Milestone (Enums)
- (RZActivityStatus)status{
    NSInteger intVal = [[self statusNumber] integerValue];
    return (RZActivityStatus)intVal;
}

- (void)setStatus:(RZActivityStatus)status{
    [self setStatusNumber:[NSNumber numberWithInteger:(NSInteger)status]];
}

@end
