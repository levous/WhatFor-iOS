//
//  RZUIStyleGuide.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZUIStyleGuide.h"
#import "RZGradientView.h"

@implementation RZUIStyleGuide

+ (UIColor *)fontColorForStatus:(RZActivityStatus)status{
    switch (status) {
        case RZActivityStatusUnknown:
            return [UIColor grayColor];
            break;
        case RZActivityStatusInProgress:
            return [UIColor colorWithRed:75.0/255 green:119.0/255 blue:190.0/255 alpha:1.0];
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

+ (void)addGradientBackgroundLightToView:(UIView *)view{
    RZGradientView *gradientView = [[RZGradientView alloc] initWithFrame:view.bounds];
    gradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIColor *colorLighter  = [UIColor colorWithWhite:0.95 alpha:1.0];
    UIColor *colorDarker = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.8 alpha:1.0];
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorDarker.CGColor, colorLighter.CGColor, colorLighter.CGColor, colorDarker.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.00];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.1];
    NSNumber *stopThree     = [NSNumber numberWithFloat:0.95];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    
    
    gradientView.layer.colors = colors;
    gradientView.layer.locations = locations;
    
    [view insertSubview:gradientView atIndex:0];
}


@end
