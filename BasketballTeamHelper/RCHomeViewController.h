//
//  RCHomeViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@class BFPaperButton;

@interface RCHomeViewController : RCViewController <UITableViewDataSource/*, UIAlertViewDelegate*/>

@property (weak, nonatomic) IBOutlet BFPaperButton *playersStatsBtn;
@property (weak, nonatomic) IBOutlet BFPaperButton *matchesStatsBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (weak, nonatomic) IBOutlet UITableView *statsTable;
@property (strong, nonatomic) NSDictionary *teamStats;

//- (IBAction)clearAllData:(id)sender;

@end
