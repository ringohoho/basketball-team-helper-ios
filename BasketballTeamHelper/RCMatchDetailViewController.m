//
//  RCMatchDetailViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCMatchDetailViewController.h"
#import "BFPaperButton.h"

typedef enum {
    MatchDetailDisplayModeStatistics,
    MatchDetailDisplayModeRecords
} MatchDetailDisplayMode;

@interface RCMatchDetailViewController ()

@property MatchDetailDisplayMode displayMode;

@end

@implementation RCMatchDetailViewController

@synthesize selectedRow, match, matchAsStats, matchStats, displayMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.changeDisplayModeBtn.backgroundColor = [UIColor whiteColor];
    self.displayMode = MatchDetailDisplayModeStatistics;
    [self.changeDisplayModeBtn setTitle:@"显示详细记录" forState:UIControlStateNormal];
    self.detailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    RCTeam *team = [[RCTeam alloc] init];
    self.match = [team matches][selectedRow];
    self.matchAsStats = [team mactchAsStatsAtIndex:selectedRow];
    NSLog(@"%@", self.matchAsStats);
    self.matchStats = self.match[kStatsKey];
    self.dateLabel.text = self.match[kDateKey];
    self.commentText.text = self.match[kCommentKey];
    self.commentText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentText.layer.borderWidth = 0.3;
    self.commentText.layer.cornerRadius = 5.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDisplayMode:(id)sender
{
    if (self.displayMode == MatchDetailDisplayModeStatistics) {
        self.displayMode = MatchDetailDisplayModeRecords;
        [self.changeDisplayModeBtn setTitle:@"显示统计数据" forState:UIControlStateNormal];
        self.detailTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.displayMode = MatchDetailDisplayModeStatistics;
        [self.changeDisplayModeBtn setTitle:@"显示详细记录" forState:UIControlStateNormal];
        self.detailTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    }
    
    [self.detailTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.displayMode == MatchDetailDisplayModeRecords) {
        return [self.matchStats count];
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.displayMode == MatchDetailDisplayModeRecords) {
        static NSString *RecordCellID = @"Record Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordCellID];
        
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:2];
        
        NSDictionary *aRecord = self.matchStats[indexPath.row];
        subtitleLabel.text = [NSString stringWithFormat:@"%@", aRecord[kTimeKey]];
        titleLabel.text = [NSString stringWithFormat:@"%@ %@", aRecord[kNameKey], aRecord[kActionKey]];
        
        return cell;
    } else {
        static NSString *StatsCellID = @"Stats Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatsCellID];
        
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
        
        switch (indexPath.row) {
            case 0:
                titleLabel.text = @"总得分";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kScoreKey]];
                break;
            case 1:
                titleLabel.text = @"二分球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    self.matchAsStats[k2PointShootKey],
                                    self.matchAsStats[k2PointGoalKey],
                                    [(NSNumber *)self.matchAsStats[k2PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.matchAsStats[k2PointGoalKey] floatValue] / [(NSNumber *)self.matchAsStats[k2PointShootKey] floatValue] * 100];
                break;
            case 2:
                titleLabel.text = @"三分球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    self.matchAsStats[k3PointShootKey],
                                    self.matchAsStats[k3PointGoalKey],
                                    [(NSNumber *)self.matchAsStats[k3PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.matchAsStats[k3PointGoalKey] floatValue] / [(NSNumber *)self.matchAsStats[k3PointShootKey] floatValue] * 100];
                break;
            case 3:
                titleLabel.text = @"罚球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    self.matchAsStats[k1PointShootKey],
                                    self.matchAsStats[k1PointGoalKey],
                                    [(NSNumber *)self.matchAsStats[k1PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.matchAsStats[k1PointGoalKey] floatValue] / [(NSNumber *)self.matchAsStats[k1PointShootKey] floatValue] * 100];
                break;
            case 4:
                titleLabel.text = @"篮板";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kReboundKey]];
                break;
            case 5:
                titleLabel.text = @"助攻";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kAssistKey]];
                break;
            case 6:
                titleLabel.text = @"抢断";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kStealKey]];
                break;
            case 7:
                titleLabel.text = @"盖帽";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kBlockKey]];
                break;
            case 8:
                titleLabel.text = @"犯规";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kFoulKey]];
                break;
            case 9:
                titleLabel.text = @"失误";
                detailLabel.text = [NSString stringWithFormat:@"%@", self.matchAsStats[kFaultKey]];
                break;
            default:
                break;
        }
        
        return cell;
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self.match setValue:textView.text forKey:kCommentKey];
    RCTeam *team = [[RCTeam alloc] init];
    [team setMatch:self.match atIndex:selectedRow];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
