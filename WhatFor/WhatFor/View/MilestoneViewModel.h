//
//  MilestoneViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MilestoneViewModelStatus : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *color;
@end

@interface MilestoneViewModel : NSObject
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) MilestoneViewModelStatus *status;
@end
