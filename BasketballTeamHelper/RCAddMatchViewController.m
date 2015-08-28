//
//  RCAddMatchViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCAddMatchViewController.h"
#import "RCLiveRecordViewController.h"
#import "BFPaperButton.h"

typedef enum {
    MatchDetailDisplayModeStatistics,
    MatchDetailDisplayModeRecords
} MatchDetailDisplayMode;

@interface RCAddMatchViewController ()

@property MatchDetailDisplayMode displayMode;

@end

@implementation RCAddMatchViewController

@synthesize statsArray, displayMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString *)dataFilePath
{
    NSString *directory = NSTemporaryDirectory();
    return [directory stringByAppendingPathComponent:@"tmp_match_stats.plist"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.startRecordBtn.backgroundColor = [UIColor whiteColor];
    self.changeDisplayModeBtn.backgroundColor = [UIColor whiteColor];
    self.displayMode = MatchDetailDisplayModeRecords;
    [self.changeDisplayModeBtn setTitle:@"统计数据" forState:UIControlStateNormal];
    self.statsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.titleText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentText.layer.borderWidth = 0.3;
    self.commentText.layer.cornerRadius = 5.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        self.statsArray = [NSArray arrayWithContentsOfFile:filePath];
    }
    else
    {
        self.statsArray = [NSMutableArray array];
        [self.statsArray writeToFile:filePath atomically:YES];
    }
    [self.statsTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDisplayMode:(id)sender {
    if (self.displayMode == MatchDetailDisplayModeStatistics) {
        self.displayMode = MatchDetailDisplayModeRecords;
        [self.changeDisplayModeBtn setTitle:@"统计数据" forState:UIControlStateNormal];
        self.statsTable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    } else {
        self.displayMode = MatchDetailDisplayModeStatistics;
        [self.changeDisplayModeBtn setTitle:@"详细记录" forState:UIControlStateNormal];
        self.statsTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    [self.statsTable reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.displayMode == MatchDetailDisplayModeRecords) {
        return [self.statsArray count];
    } else {
        return 10;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.displayMode == MatchDetailDisplayModeRecords) {
        static NSString *RecordCellID = @"Record Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordCellID];
        int row = (int)indexPath.row;
        
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:2];
        
        subtitleLabel.text = [NSString stringWithFormat:@"%@", self.statsArray[row][kTimeKey]];
        titleLabel.text = [NSString stringWithFormat:@"%@ %@", self.statsArray[row][kNameKey], self.statsArray[row][kActionKey]];
        
        return cell;
    } else {
        static NSString *StatsCellID = @"Stats Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatsCellID];
        
        UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
        UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
        
        NSDictionary *matchAsStats = [RCTeam matchAsStatsWithMatch:[NSDictionary dictionaryWithObject:self.statsArray forKey:kStatsKey]];
        
        switch (indexPath.row) {
            case 0:
                titleLabel.text = @"总得分";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kScoreKey]];
                break;
            case 1:
                titleLabel.text = @"二分球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    matchAsStats[k2PointShootKey],
                                    matchAsStats[k2PointGoalKey],
                                    [(NSNumber *)matchAsStats[k2PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)matchAsStats[k2PointGoalKey] floatValue] / [(NSNumber *)matchAsStats[k2PointShootKey] floatValue] * 100];
                break;
            case 2:
                titleLabel.text = @"三分球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    matchAsStats[k3PointShootKey],
                                    matchAsStats[k3PointGoalKey],
                                    [(NSNumber *)matchAsStats[k3PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)matchAsStats[k3PointGoalKey] floatValue] / [(NSNumber *)matchAsStats[k3PointShootKey] floatValue] * 100];
                break;
            case 3:
                titleLabel.text = @"罚球";
                detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                    matchAsStats[k1PointShootKey],
                                    matchAsStats[k1PointGoalKey],
                                    [(NSNumber *)matchAsStats[k1PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)matchAsStats[k1PointGoalKey] floatValue] / [(NSNumber *)matchAsStats[k1PointShootKey] floatValue] * 100];
                break;
            case 4:
                titleLabel.text = @"篮板";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kReboundKey]];
                break;
            case 5:
                titleLabel.text = @"助攻";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kAssistKey]];
                break;
            case 6:
                titleLabel.text = @"抢断";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kStealKey]];
                break;
            case 7:
                titleLabel.text = @"盖帽";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kBlockKey]];
                break;
            case 8:
                titleLabel.text = @"犯规";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kFoulKey]];
                break;
            case 9:
                titleLabel.text = @"失误";
                detailLabel.text = [NSString stringWithFormat:@"%@", matchAsStats[kFaultKey]];
                break;
            default:
                break;
        }
        
        return cell;
    }
}

- (void)save:(id)sender
{
    if ([self.titleText.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"比赛标题可不能为空哦～"
                                                        message:@"至少给这场比赛起个标题再保存吧！"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    if ([self.statsArray count] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"比赛记录可不能为空哦～"
                                                        message:@"点“开始记录”到实时记录页面，就可以开始记录实时比赛信息了。"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    RCTeam *team = [[RCTeam alloc] init];
    [team addMatch:self.titleText.text atDate:[NSDate date] withStats:self.statsArray andComment:self.commentText.text];
    
    [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender
{
    [[NSFileManager defaultManager] removeItemAtPath:[self dataFilePath] error:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 
 }
 */

@end
