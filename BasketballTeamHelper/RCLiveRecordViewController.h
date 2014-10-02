//
//  RCLiveRecordViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@class RCAddMatchViewController, BFPaperButton;

@interface RCLiveRecordViewController : RCViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet BFPaperButton *addRecordBtn;
@property (strong, nonatomic) NSMutableArray *statsArray;
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITableView *statsTable;
@property (strong, nonatomic) NSArray *players;
@property (strong, nonatomic) NSArray *actions;

- (IBAction)addOneRecord:(id)sender;

@end
