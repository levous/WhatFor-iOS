//
//  RZMilestoneAddViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/29/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZIncentiveEditViewController.h"
#import "RZStringsHelper.h"

@interface RZIncentiveEditViewController ()

@end

@implementation RZIncentiveEditViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Add Incentive"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(localeChanged:)
                                                 name:NSCurrentLocaleDidChangeNotification
                                               object:nil];
    
    
    [self populateFromViewModel];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSCurrentLocaleDidChangeNotification
                                                  object:nil];
}

#pragma mark - Locale

/*! Responds to region format or locale changes.
 */
- (void)localeChanged:(NSNotification *)notif
{
    // the user changed the locale (region format) in Settings, so we are notified here to
    // update the date format in the table view cells
    //
    [self.tableView reloadData];
}


#pragma mark - Populate data

- (void)populateFromViewModel{
    [[self titleTextField] setText:[[self incentiveViewModel] title]];
    [[self summaryTextView] setText:[[self incentiveViewModel] summary]];
}


#pragma mark - Bar Button Handlers

- (IBAction)cancel:(id)sender
{
	[self.delegate incentiveEditViewControllerDidCancel:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)done:(id)sender
{
    RZIncentiveViewModel *vm = [self incentiveViewModel];
    
    [vm setTitle:[[self titleTextField] text]];
    [vm setSummary:[[self summaryTextView] text]];
    [self.delegate incentiveEditViewController:self didUpdateIncentive:[self incentiveViewModel]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Memory

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
