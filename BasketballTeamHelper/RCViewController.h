//
//  RCViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-12.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCHelper.h"
#import "RCTeam.h"

@class RCToolbar;

@interface RCViewController : UIViewController

@property (strong, nonatomic) RCToolbar *inputAccessoryBar;

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (UIResponder *)findFirstResponder;
- (IBAction)backgroundTap:(id)sender;

@end
