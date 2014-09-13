//
//  RZMilestoneCell.m
//  WhatFor
//
//  Created by Rusty Zarse on 8/26/14.
//  Copyright (c) 2014 Levous, LLC. All rights reserved.
//

#import "RZMilestoneCell.h"
#import "RZMilestoneViewModel.h"
#import "UIView+QuartzEffects.h"

@implementation RZMilestoneCell


+ (NSString *)defaultReuseIdentifier{ return @"milestoneCell"; }



- (id)initWithCoder:(NSCoder *)aDecoder{
    self =  [super initWithCoder:aDecoder];
    if(self){
        [self addRoundBorder:[self completeButton]];
    }
    return self;
}

- (void)awakeFromNib{
    [self addRoundBorder:[self completeButton]];
}

//NOTE: weak reference.  Used to populate other data and then discarded
- (RZMilestoneViewModel *)milestoneViewModel{
    return _milestoneViewModel;
}

- (void)setMilestoneViewModel:(RZMilestoneViewModel *)milestoneViewModel{
    _milestoneViewModel = milestoneViewModel;
    
    [[self titleLabel] setText:[milestoneViewModel title]];
    [[self statusLabel] setText:[[milestoneViewModel status] title]];
    [[self statusLabel] setTextColor:[[milestoneViewModel status] color]];
    //[[self contentView] setBackgroundColor:[[milestoneViewModel status] backgroundColor]];
    
    if ([[milestoneViewModel status] status] == RZActivityStatusBlocked) {
        [[self contentView] flashElipseWithColor:[[milestoneViewModel status] color]];
    }
    
    BOOL isCompleted = ( [[milestoneViewModel status] status] == RZActivityStatusComplete );
    [[self completeButton] setHidden:isCompleted];
}
   

- (void)addRoundBorder:(UIView *)view{
    view.layer.cornerRadius = 5;
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithRed:167.0/255.0 green:140.0/255.0 blue:98.0/255.0 alpha:0.25].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    if(selected && [self delegate] != nil){
        [[self delegate] didSelectMilestoneCell:self];
    }
}

- (IBAction)milestoneComplete:(id)sender {
    if([self delegate] != nil){
        [[self delegate] didCompleteMilestoneCell:self];
    }
}

- (void)animateCompletion {
    UIView *buttonView = self.completeButton;
    buttonView.transform = CGAffineTransformIdentity;
    CGRect buttonFrame = [buttonView frame];
    [UIView animateWithDuration:0.1 animations:^{
        buttonView.alpha = 1.0;
        buttonView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL iFinished) {
        [UIView animateWithDuration:(0.4) animations:^{
            buttonView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            buttonView.backgroundColor = [UIColor clearColor];
            buttonView.alpha = 0.0;
        } completion:^(BOOL iFinished) {
            [buttonView setHidden:YES];
            [buttonView setFrame:buttonFrame];
            buttonView.alpha = 1.0;
        }];
    }];
}


@end
