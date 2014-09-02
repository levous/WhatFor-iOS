//
//  RZGoalViewModelTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 9/2/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZTestingRepository.h"
#import "RZSeedDataInserter.h"
#import "Goal.h"
#import "RZGoalViewModel.h"


@interface RZGoalViewModelTests : XCTestCase

@end

@implementation RZGoalViewModelTests

RZTestingRepository *repos;
RZSeedDataInserter *seedInserter;

- (void)setUp
{
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
    repos = [[RZTestingRepository alloc] init];
    // insert 2 goals with 4 and 3 milestones, respectively
    seedInserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [seedInserter insert2GoalsWith4and3Milestones];

}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testInitialization
{
    Goal *goal = [[repos getAllGoals] objectAtIndex:0];
    
    [goal setTitle:@"The Title"];
    [goal setSortOrder:@10];
    [goal setSummary:@"The Summary Chump"];
    
    NSUInteger milestoneCount = [[goal goalMilestones] count];
    
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal];
    
    XCTAssertEqualObjects([goalVM title], @"The Title");
    XCTAssertEqualObjects([goalVM summary], @"The Summary Chump");
    XCTAssertEqual([[goalVM milestones] count], milestoneCount);
    
}

@end
