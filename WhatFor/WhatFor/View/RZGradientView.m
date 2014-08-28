//
//  RZGradientView.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/28/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGradientView.h"

@implementation RZGradientView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

+ (Class)layerClass {
    return [CAGradientLayer class];
}   

@end
