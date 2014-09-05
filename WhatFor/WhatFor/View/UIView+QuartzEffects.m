//
//  UIView+QuartzEffects.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/28/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "UIView+QuartzEffects.h"

@implementation UIView (QuartzEffects)

//Metallic grey gradient background
- (void) RZGradientGrey {
    
    UIColor *colorOne = [UIColor colorWithWhite:0.9 alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.85 alpha:1.0];
    UIColor *colorThree     = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.7 alpha:1.0];
    UIColor *colorFour = [UIColor colorWithHue:0.625 saturation:0.0 brightness:0.4 alpha:1.0];
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, colorThree.CGColor, colorFour.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.02];
    NSNumber *stopThree     = [NSNumber numberWithFloat:0.99];
    NSNumber *stopFour = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, stopThree, stopFour, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    
    headerLayer.frame = self.bounds;
    [self.layer insertSublayer:headerLayer atIndex:0];
    
}

//Blue gradient background
- (void) RZGradientBlue {
    
    UIColor *colorOne = [UIColor colorWithRed:(120/255.0) green:(135/255.0) blue:(150/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(57/255.0)  green:(79/255.0)  blue:(96/255.0)  alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    
    headerLayer.frame = self.bounds;
    [self.layer insertSublayer:headerLayer atIndex:0];
    
}

- (void)flashElipseWithColor:(UIColor *)color{
    // Set up the shape of the circle
    CAShapeLayer *circle = [CAShapeLayer layer];
    // Make a circular shape
    circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(3.0, 3.0, self.frame.size.width - 6.0, self.frame.size.height - 6.0)] .CGPath;
    // Center the shape in self.view
    circle.position = CGPointMake(0,0);
    
    // Configure the apperence of the circle
    circle.fillColor = [UIColor clearColor].CGColor;
    circle.strokeColor = color.CGColor;
    circle.lineWidth = 3;
    
    // Add to parent layer
    [self.layer addSublayer:circle];
    
    // Configure animation
    CABasicAnimation *drawAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    drawAnimation.duration            = 0.5; // "animate over .5 seconds or so.."
    drawAnimation.repeatCount         = 1.0;  // Animate only once..
    
    // Animate from no part of the stroke being drawn to the entire stroke being drawn
    drawAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    drawAnimation.toValue   = [NSNumber numberWithFloat:1.0f];
    
    // Experiment with timing to get the appearence to look the way you want
    drawAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    // Add the animation to the circle
    [circle addAnimation:drawAnimation forKey:@"drawCircleAnimation"];
    // then fade the circle
    CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOutAnimation.fromValue = [NSNumber numberWithInt:1];
    fadeOutAnimation.toValue = [NSNumber numberWithInt:0];
    fadeOutAnimation.duration = 1.0;
    fadeOutAnimation.fillMode = kCAFillModeForwards;
    fadeOutAnimation.removedOnCompletion = NO;
    
    [circle addAnimation:fadeOutAnimation forKey:@"fadeOut"];
}

@end
