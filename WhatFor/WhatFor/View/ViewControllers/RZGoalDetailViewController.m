//
//  RZGoalDetailViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/27/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZGoalDetailViewController.h"

@interface RZGoalDetailViewController ()

@end

@implementation RZGoalDetailViewController

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
    [self setTitle:@"Goal"];
    
    [[self titleLabel] setText:[[self goalViewModel] title]];
    [[self summaryTextView] setText:[[self goalViewModel] summary]];
    //[[self statusLabel] setText:[[[self goalViewModel] status] title]];
    //[[self statusLabel] setTextColor:[[[self goalViewModel] status] color]];
    //[[self dateDueLabel] setText:[[self goalViewModel] dateDue]];
    //[[self timeRemainingLabel] setText:[[self goalViewModel] timeRemaining]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
