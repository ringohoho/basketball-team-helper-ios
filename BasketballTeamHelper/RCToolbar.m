//
//  RCToolbar.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-23.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCToolbar.h"
#import "RCViewController.h"
#import "RCHelper.h"

@implementation RCToolbar

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithTitle:@"隐藏" style:UIBarButtonItemStyleDone target:nil action:@selector(save)];
        [saveBtn setTintColor:DEFAULT_TINT_COLOR];
        [self setItems:[NSArray arrayWithObject:saveBtn] animated:YES];
        [self sizeToFit];
    }
    return self;
}

- (void)save
{
    [[(RCViewController *)self.delegate findFirstResponder] resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
