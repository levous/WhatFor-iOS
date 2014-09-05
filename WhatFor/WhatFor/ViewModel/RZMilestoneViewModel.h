//
//  MilestoneViewModel.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Milestone;

#import "Milestone+Enums.h"
#import "RZStatusViewModel.h"
#import "RZCoreDataRepository.h"

@interface RZMilestoneViewModel : NSObject{
    //RZCoreDataRepository *_repository;
}
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *goalTitle;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *dateDueText;
@property (strong, nonatomic) NSDate *dateDue;
@property (strong, nonatomic) NSString *timeRemaining;
@property (strong, nonatomic) RZStatusViewModel *status;

@property (strong, nonatomic) Milestone *milestone;

- (id)initWithMilestone:(Milestone *)milestone;
- (void)updateMilestoneFromViewModel;
@end
