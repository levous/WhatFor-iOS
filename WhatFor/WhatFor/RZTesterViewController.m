//
//  RZTesterViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZTesterViewController.h"
#import "RZSeedDataInserter.h"
#import "RZAppDelegate.h"
#import "RZCoreDataRepository.h"
#import "RZSeedDataInserter.h"

@interface RZTesterViewController ()

@end

@implementation RZTesterViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clearPressed:(id)sender {
}
- (IBAction)reseedPressed:(id)sender {
    
    RZAppDelegate *appDelegate = (RZAppDelegate *)[[UIApplication sharedApplication] delegate];
    RZCoreDataRepository *repos = [appDelegate coreDataRepository];
    RZSeedDataInserter *seeder = [[RZSeedDataInserter alloc] initWithRepository:repos];
    [seeder seedAllData];
}

@end
