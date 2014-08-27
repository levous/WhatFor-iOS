//
//  RZSeedDataInserter.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZSeedDataInserter.h"
#import "Milestone+Enums.h"

@implementation RZSeedDataInserter

RZCoreDataRepository *_repos;

- (id)initWithRepository:(RZCoreDataRepository *)repos
{
    self = [self init];
    if (self) {
        _repos = repos;
    }
    return self;
}

- (void)seedAllData{
    [self insert2GoalsWith4and3Milestones];
}

// This method is used for explicit testts so be sure to update tests if you change this content.  It would be ok to remove from seedAllDataif that's easier

- (void)insert2GoalsWith4and3Milestones{

    Goal *goal = _repos.createGoal;
    [goal setTitle:@"Goal 1 set up project"];
    [goal setSortOrder:[NSNumber numberWithInt:1]];
    
    Milestone *milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.1 continuous integration server"];
    [milestone setSummary:@"Metus pellentesque, nunc porttitor cum phasellus arcu, duis sollicitudin libero purus tristique sodales quis, consequat vehicula aliquam nisl ante, cras porttitor nulla."];
    [milestone setStatus:RZActivityStatusInProgress];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.2 core data repository"];
    [milestone setSummary:@"Lorem ipsum dolor sit amet, natoque viverra iaculis lacinia diam es."];
    [milestone setStatus:RZActivityStatusComplete];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.3 test repository"];
    [milestone setSummary:@"Libero purus tristique sodales quis, consequat vehicula aliquam nisl ante, cras porttitor nulla libero. Sollicitudin justo hymenaeos. Vivamus integer, tristique nonummy justo nisl ante eget."];
    [milestone setStatus:RZActivityStatusInProgress];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 1.4 author stories"];
    [milestone setSummary:@"Cras porttitor nulla libero."];
    [milestone setStatus:RZActivityStatusComplete];
    
    goal = _repos.createGoal;
    [goal setTitle:@"Goal 2 Best Practices"];
    [goal setSortOrder:[NSNumber numberWithInt:2]];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.1 development lifecycle"];
    [milestone setSummary:@"Urna odio ipsum per in phasellus curabitur. Commodo etiam varius dolore nulla suscipit egestas, nec morbi vehicula scelerisque eget. Metus per egestas neque placerat, mi nullam gravida, nullam modi sodales felis nec odio. Est vitae tincidunt ac lacus, est libero phasellus pellentesque vestibulum id eleifend, laoreet vestibulum ullamcorper sed phasellus."];
    [milestone setStatus:RZActivityStatusInProgress];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.2 deliver stories"];
    [milestone setSummary:@"Commodo etiam varius dolore nulla suscipit egestas, nec morbi vehicula scelerisque eget."];
    [milestone setStatus:RZActivityStatusBlocked];
    
    milestone = [_repos createMilestoneForGoal:goal];
    [milestone setTitle:@"Milestone 2.3 ensure test coverage"];
    [milestone setSummary:@"Pellentesque vestibulum id eleifend, laoreet vestibulum ullamcorper sed phasellus."];
    [milestone setStatus:RZActivityStatusUnknown];

    [_repos saveContext];
    
}

@end
