//
//  RCHomeViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCHomeViewController.h"
#import "RCHelper.h"
#import "BFPaperButton.h"

@interface RCHomeViewController ()

@end

@implementation RCHomeViewController

@synthesize teamStats;

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
    self.playersStatsBtn.backgroundColor = [UIColor whiteColor];
    self.matchesStatsBtn.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)loadData
{
    RCTeam *team = [[RCTeam alloc] init];
    self.nameLabel.text = [team name];
    self.commentText.text = [team comment];
    self.teamStats = [team stats];
    [self.statsTable reloadData];
}

/*- (void)clearAllData
{
    NSError *err;
    [[NSFileManager defaultManager] removeItemAtPath:[RCHelper dataFilePath] error:&err];
    if (err != nil)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败"
                                                        message:@"清空所有数据失败了，请您稍后或重启应用再试吧～"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作成功"
                                                    message:@"所有数据都清空了，重新开启你的球队吧～"
                                                   delegate:nil
                                          cancelButtonTitle:@"知道了"
                                          otherButtonTitles:nil, nil];
    [alert show];
    
    [self loadData];
}

- (IBAction)clearAllData:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清空所有数据"
                                                    message:@"你确定要继续？这将会清空你所记录的所有数据，应用将恢复到初始状态！"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"清空数据", nil];
    [alert show];
}*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StatsCellID = @"Stats Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatsCellID];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
    switch (indexPath.row)
    {
        case 0:
            titleLabel.text = @"总得分";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kScoreKey]];
            break;
        case 1:
            titleLabel.text = @"二分球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                self.teamStats[k2PointShootKey],
                                self.teamStats[k2PointGoalKey],
                                [(NSNumber *)self.teamStats[k2PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.teamStats[k2PointGoalKey] floatValue] / [(NSNumber *)self.teamStats[k2PointShootKey] floatValue] * 100];
            break;
        case 2:
            titleLabel.text = @"三分球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                self.teamStats[k3PointShootKey],
                                self.teamStats[k3PointGoalKey],
                                [(NSNumber *)self.teamStats[k3PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.teamStats[k3PointGoalKey] floatValue] / [(NSNumber *)self.teamStats[k3PointShootKey] floatValue] * 100];
            break;
        case 3:
            titleLabel.text = @"罚球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                self.teamStats[k1PointShootKey],
                                self.teamStats[k1PointGoalKey],
                                [(NSNumber *)self.teamStats[k1PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)self.teamStats[k1PointGoalKey] floatValue] / [(NSNumber *)self.teamStats[k1PointShootKey] floatValue] * 100];
            break;
        case 4:
            titleLabel.text = @"篮板";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kReboundKey]];
            break;
        case 5:
            titleLabel.text = @"助攻";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kAssistKey]];
            break;
        case 6:
            titleLabel.text = @"抢断";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kStealKey]];
            break;
        case 7:
            titleLabel.text = @"盖帽";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kBlockKey]];
            break;
        case 8:
            titleLabel.text = @"犯规";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kFoulKey]];
            break;
        case 9:
            titleLabel.text = @"失误";
            detailLabel.text = [NSString stringWithFormat:@"%@", self.teamStats[kFaultKey]];
            break;
        default:
            break;
    }
    
    return cell;
}

/*- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self clearAllData];
    }
}*/

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Players Stats"])
    {
        RCTeam *team = [[RCTeam alloc] init];
        NSArray *players = [team players];
        if ([players count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有添加过球员哦～"
                                                            message:@"只有先到“添加球员”页面去添加球员，才能看球员数据哦～"
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    else if ([identifier isEqualToString:@"Matches Stats"])
    {
        RCTeam *team = [[RCTeam alloc] init];
        NSArray *matches = [team matches];
        if ([matches count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有添加过场次哦～"
                                                            message:@"只有先到“添加场次”页面去添加场次，才能看场次数据哦～"
                                                           delegate:nil
                                                  cancelButtonTitle:@"知道了"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }
    }
    
    return YES;
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
