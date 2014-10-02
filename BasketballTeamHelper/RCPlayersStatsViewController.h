//
//  RCPlayersStatsViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-6-2.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@class RCTextFieldWithPicker;

@interface RCPlayersStatsViewController : RCViewController <UITableViewDataSource, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet RCTextFieldWithPicker *playerText;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (weak, nonatomic) IBOutlet UITableView *statsTable;
@property (strong, nonatomic) UIPickerView *playerPicker;
@property (strong, nonatomic) NSMutableArray *players;

- (IBAction)deletePlayer:(id)sender;

@end
