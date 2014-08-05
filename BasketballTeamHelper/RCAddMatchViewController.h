//
//  RCAddMatchViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@interface RCAddMatchViewController : RCViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (weak, nonatomic) IBOutlet UITableView *statsTable;
@property (strong, nonatomic) NSArray *statsArray;

@end
