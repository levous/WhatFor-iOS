//
//  RZMilestoneDetailViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneDetailViewController.h"

@interface RZMilestoneDetailViewController ()

@end

@implementation RZMilestoneDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[self titleLabel] setText:[[self milestoneViewModel] title]];
    [[self summaryTextView] setText:[[self milestoneViewModel] summary]];
    [[self statusLabel] setText:[[[self milestoneViewModel] status] title]];
    [[self statusLabel] setTextColor:[[[self milestoneViewModel] status] color]];
    [[self dateDueLabel] setText:[[self milestoneViewModel] dateDue]];
    [[self timeRemainingLabel] setText:[[self milestoneViewModel] timeRemaining]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
