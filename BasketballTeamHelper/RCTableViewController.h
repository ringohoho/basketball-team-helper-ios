//
//  RCTableViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 10/2/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCTableViewController : UITableViewController

- (IBAction)save:(id)sender;
- (IBAction)cancel:(id)sender;
- (UIResponder *)findFirstResponder;

@end
