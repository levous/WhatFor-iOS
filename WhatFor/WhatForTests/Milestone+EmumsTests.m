//
//  Milestone+EmumsTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZTestingRepository.h"
#import "ModelHeader.h"
#import "RZSeedDataInserter.h"
#import "Milestone+Enums.h"

@interface Milestone_EmumsTests : XCTestCase

@end

@implementation Milestone_EmumsTests
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

- (void)testStatusNumberConversion{
    RZSeedDataInserter *inserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [inserter insert2GoalsWith4and3Milestones];
    
    NSArray *goals = [repos getAllGoals];
    Goal *goal = [goals objectAtIndex:0];
    goal = [goals objectAtIndex:1];
    Milestone *milestone = [[goal goalMilestones] objectAtIndex:0];
    // set and check the status.  Persistence is not really the responsibility of the category so assume things are working if the value comes back out
    [milestone setStatus:RZActivityStatusInProgress];
    XCTAssertEqual([milestone status], RZActivityStatusInProgress);
    [milestone setStatus:RZActivityStatusComplete];
    XCTAssertEqual([milestone status], RZActivityStatusComplete);
    [milestone setStatus:RZActivityStatusBlocked];
    XCTAssertEqual([milestone status], RZActivityStatusBlocked);
    
}

@end
