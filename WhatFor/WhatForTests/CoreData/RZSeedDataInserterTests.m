//
//  RZSeedDataInserterTests.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RZTestingRepository.h"
#import "ModelHeader.h"
#import "RZSeedDataInserter.h"

@interface RZSeedDataInserterTests : XCTestCase

@end

@implementation RZSeedDataInserterTests


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

- (void)testInsert2GoalsWith4and3Milestones{
    RZSeedDataInserter *inserter = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [inserter insert2GoalsWith4and3Milestones];
    
    NSArray *goals = [repos getAllGoals];
    XCTAssertEqual([goals count], (NSUInteger)2);
    Goal *goal = [goals objectAtIndex:0];
    XCTAssertEqual([[goal goalMilestones] count], (NSUInteger)4);
    goal = [goals objectAtIndex:1];
    XCTAssertEqual([[goal goalMilestones] count], (NSUInteger)3);
}

@end
