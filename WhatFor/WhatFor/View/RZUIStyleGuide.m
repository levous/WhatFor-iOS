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
            return [UIColor colorWithRed:31.0/255 green:58.0/255 blue:147.0/255 alpha:1.0];
            break;
        case RZActivityStatusComplete:
            return [UIColor colorWithRed:30.0/255 green:130.0/255 blue:76.0/255 alpha:1.0];
            break;
        case RZActivityStatusBlocked:
            return [UIColor colorWithRed:207.0/255 green:0 blue:15.0/255 alpha:1.0];
            break;
        
        default:
            break;
    }
}
@end
