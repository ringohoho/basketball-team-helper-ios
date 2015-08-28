//
//  RCMatchDetailViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@class BFPaperButton;

@interface RCMatchDetailViewController : RCViewController <UITableViewDataSource, UITextViewDelegate>

@property (weak, nonatomic) IBOutlet BFPaperButton *changeDisplayModeBtn;
@property (weak, nonatomic) IBOutlet UITableView *detailTableView;

@property int selectedRow;
@property (strong, nonatomic) NSDictionary *match;
@property (strong, nonatomic) NSDictionary *matchAsStats; // 这里 as stats 表示比赛的统计数据, 而不是详细的每条记录, 和下面的区分
@property (strong, nonatomic) NSArray *matchStats; // 这里的 stats 实则不是统计数据, 而是详细记录, 当时命名有问题
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *commentText;

- (IBAction)changeDisplayMode:(id)sender;

@end
