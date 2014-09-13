//
//  RZStatusViewModel.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/4/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZStatusViewModel.h"
#import "RZUIStyleGuide.h"
#import "RZStringsHelper.h"

@implementation RZStatusViewModel

- (void)setStatus:(RZActivityStatus)status {
    _status = status;
    _title = [RZStringsHelper titleForActivityStatus:status];
    _color = [RZUIStyleGuide fontColorForStatus:status];
    _backgroundColor = [RZUIStyleGuide backgroundColorForStatus:status];
}

- (RZActivityStatus) status{
    return _status;
}

@end
