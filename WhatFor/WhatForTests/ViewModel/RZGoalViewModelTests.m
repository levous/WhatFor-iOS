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
#import "Milestone+Enums.h"



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
    
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqualObjects([goalVM title], @"The Title");
    XCTAssertEqualObjects([goalVM summary], @"The Summary Chump");
    XCTAssertEqual([[goalVM milestones] count], milestoneCount);
    
}

- (void)testStatus
{
    Goal *goal = [[repos getAllGoals] objectAtIndex:0];
    
    for(Milestone *m in [goal goalMilestones]){
        [m setStatus:RZActivityStatusUnknown];
    }
    
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    // all not started, goal not started
    XCTAssertEqual([[goalVM status] status], RZActivityStatusUnknown);

    
    // any not unknown, goal in progress
    Milestone *milestone = [[goal goalMilestones] objectAtIndex:1];
    [milestone setStatus:RZActivityStatusInProgress];
    
    goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqual([[goalVM status] status], RZActivityStatusInProgress);
    
    // any not complete, still in progress
    [milestone setStatus:RZActivityStatusComplete];
    
    goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqual([[goalVM status] status], RZActivityStatusInProgress);
    
    // any blocked, goal is blocked
    [milestone setStatus:RZActivityStatusBlocked];
    
    goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqual([[goalVM status] status], RZActivityStatusBlocked);
    
    // all complete, goal complete
    [milestone setStatus:RZActivityStatusComplete];
    
    goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqual([[goalVM status] status], RZActivityStatusInProgress);
    
}

- (void)testSaveMilestone{
    Goal *goal = [[repos getAllGoals] objectAtIndex:0];
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    Milestone *milestone = [[goal goalMilestones] objectAtIndex:0];
    
    RZMilestoneViewModel *mvm = [[goalVM milestones] objectAtIndex:0];
    
    XCTAssertEqual(milestone, [mvm milestone]);
    
    [mvm setTitle:@"Testing a Title Change"];
    [mvm setSummary:@"Testing a Summary Change"];
    [[mvm status] setStatus:RZActivityStatusBlocked];
    
    XCTAssertNotEqualObjects([milestone title], @"Testing a Title Change");
    
    [goalVM saveMilestone:mvm];

    XCTAssertEqualObjects([milestone title], @"Testing a Title Change");
    XCTAssertEqualObjects([milestone summary], @"Testing a Summary Change");
    XCTAssertEqual ([milestone status], RZActivityStatusBlocked);

}

- (void)testSaveGoal{
    Goal *goal = [[repos getAllGoals] objectAtIndex:0];
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:goal andRepository:repos];
    
    XCTAssertEqualObjects([goal title], [goalVM title]);
    
    [goalVM setTitle:@"Testing a Title Change"];
    [goalVM setSummary:@"Testing a Summary Change"];
    
    XCTAssertNotEqualObjects([goal title], [goalVM title]);
    
    [goalVM save];
    
    XCTAssertEqualObjects([goal title], @"Testing a Title Change");
    XCTAssertEqualObjects([goal summary], @"Testing a Summary Change");
    
    
}

- (void)testAddGoal{
    NSArray *allGoals = [repos getAllGoals];
    NSUInteger initialCount = [allGoals count];
    RZGoalViewModel *goalVM = [[RZGoalViewModel alloc] initWithGoal:nil andRepository:repos];

    
    [goalVM setTitle:@"New Goal"];
    [goalVM setSummary:@"New Goal Summary"];
    [goalVM save];
    
    allGoals = [repos getAllGoals];
    NSUInteger finalCount = [allGoals count];

    
    XCTAssertEqual(finalCount, initialCount + 1);
    
    
}


@end
