//
//  RZUIStyleGuide.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZUIStyleGuide.h"

@implementation RZUIStyleGuide

+ (UIColor *)fontColorForStatus:(RZActivityStatus)status{
    switch (status) {
        case RZActivityStatusUnknown:
            return [UIColor grayColor];
            break;
        case RZActivityStatusInProgress:
            return [UIColor blueColor];
            break;
        case RZActivityStatusComplete:
            return [UIColor greenColor];
            break;
        case RZActivityStatusBlocked:
            return [UIColor redColor];
            break;
        
        default:
            break;
    }
}
@end
