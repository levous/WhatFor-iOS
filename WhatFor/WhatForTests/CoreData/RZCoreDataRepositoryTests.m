//
//  RZCoreDataRepositoryTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZTestingRepository.h"
#import "ModelHeader.h"

@interface RZCoreDataRepositoryTests : XCTestCase
@end

@implementation RZCoreDataRepositoryTests

RZTestingRepository *repos;
- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    repos = [[RZTestingRepository alloc] init];

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testCreateGoal
{
    Goal *goal = [repos createGoal];
    XCTAssertNotNil(goal);
}

- (void)testCreateMilestoneForGoal
{
    Goal *goal = [repos createGoal];
    Milestone *milestone = [repos createMilestoneForGoal:goal];
    XCTAssertNotNil(goal);
    XCTAssertEqualObjects(goal, milestone.milestoneGoal);
}

@end
