//
//  RZMilestonesHeaderCell.h
//  WhatFor
//
//  Created by Rusty Zarse on 8/28/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZMilestonesHeaderCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
- (IBAction)addPressed:(id)sender;
+ (NSString *)defaultReuseIdentifier;
@end
