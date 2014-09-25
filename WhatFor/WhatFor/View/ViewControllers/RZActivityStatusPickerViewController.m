//
//  RZActivityStatusPickerViewController.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/31/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZActivityStatusPickerViewController.h"
#import "RZStringsHelper.h"

@interface RZActivityStatusPickerViewController ()

@end

@implementation RZActivityStatusPickerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    statusArray = @[
                    [RZStringsHelper titleForActivityStatus:(RZActivityStatus)0], // RZActivityStatusNotStarted
                    [RZStringsHelper titleForActivityStatus:(RZActivityStatus)1], // RZActivityStatusBlocked
                    [RZStringsHelper titleForActivityStatus:(RZActivityStatus)2], // RZActivityStatusComplete
                    [RZStringsHelper titleForActivityStatus:(RZActivityStatus)3], // RZActivityStatusBlocked
                    ];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [statusArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"statusCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSString *statusTitle = [statusArray objectAtIndex:indexPath.row];
    [[cell textLabel] setText:statusTitle];
    
    
    if ([statusTitle isEqualToString:[RZStringsHelper titleForActivityStatus:[self selectedStatus]]]) {
        [tableView
         selectRowAtIndexPath:indexPath
         animated:TRUE
         scrollPosition:UITableViewScrollPositionNone
         ];
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // safe to do only because the array is defined literally above..  pretty fragile, otherwise :)
    RZActivityStatus status = (RZActivityStatus)indexPath.row;
    
    [self setSelectedStatus:status];
    if([self delegate] != nil){
        [[self delegate] rzactivityStatusPickerViewController:self
                                              didSelectStatus:status];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
