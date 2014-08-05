//
//  RCMatchDetailViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@interface RCMatchDetailViewController : RCViewController <UITableViewDataSource, UITextViewDelegate>

@property int selectedRow;
@property (strong, nonatomic) NSDictionary *match;
@property (strong, nonatomic) NSArray *matchStats;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;

@end
