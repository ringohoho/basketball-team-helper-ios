//
//  RCTextFieldWithPicker.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-11.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCTextFieldWithPicker.h"

@implementation RCTextFieldWithPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(cut:) || action == @selector(paste:) || action == @selector(select:) || action == @selector(selectAll:))
        return NO;
    return [super canPerformAction:action withSender:sender];
}

@end
