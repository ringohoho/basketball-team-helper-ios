//
//  RCPlayersStatsViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-6-2.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCPlayersStatsViewController.h"
#import "RCTextFieldWithPicker.h"

@interface RCPlayersStatsViewController ()

@end

@implementation RCPlayersStatsViewController

@synthesize playerPicker, players;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    RCTeam *team = [[RCTeam alloc] init];
    self.players = [NSMutableArray arrayWithArray:[team players]];
    self.playerText.text = [self.players count] == 0 ? @"" : self.players[0][kNameKey];
    self.playerPicker = [[UIPickerView alloc] init];
    self.playerPicker.backgroundColor = [UIColor whiteColor];
    self.playerPicker.dataSource = self;
    self.playerPicker.delegate = self;
    self.playerText.inputView = self.playerPicker;
    self.playerText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.text = [self.players count] == 0 ? @"" : self.players[0][kCommentKey];
    self.commentText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.positionLabel.text = [self.players count] == 0 ? @"" : self.players[0][kPositionKey];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    RCTeam *team = [[RCTeam alloc] init];
    [team setPlayers:self.players];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)deletePlayer:(id)sender
{
    if ([self.players count] == 0)
        return;
    
    NSString *playerName = self.playerText.text;
    RCTeam *team = [[RCTeam alloc] init];
    int playerIndex = [team indexOfPlayer:playerName];
    if (playerIndex < 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"无法删除"
                                                        message:[NSString stringWithFormat:@"没能找到“%@”这个球员哦～", playerName]
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        [self.players removeObjectAtIndex:playerIndex];
        [self.playerPicker reloadAllComponents];
        self.playerText.text = [players count] == 0 ? @"" : self.players[0][kNameKey];
        self.positionLabel.text = [self.players count] == 0 ? @"" : self.players[0][kPositionKey];
        self.commentText.text = [self.players count] == 0 ? @"" : self.players[0][kCommentKey];
        [self.statsTable reloadData];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"删除成功"
                                                        message:[NSString stringWithFormat:@"成功删除“%@”这个球员。", playerName]
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.players count] == 0)
        return;
    
    NSString *playerName = self.playerText.text;
    RCTeam *team = [[RCTeam alloc] init];
    int playerIndex = [team indexOfPlayer:playerName];
    if (playerIndex < 0)
        return;
    [self.players[playerIndex] setValue:self.commentText.text forKey:kCommentKey];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.players count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.players[row][kNameKey];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.playerText.text = [self.players count] == 0 ? @"" : self.players[row][kNameKey];
    self.positionLabel.text = [self.players count] == 0 ? @"" : self.players[row][kPositionKey];
    self.commentText.text = [self.players count] == 0 ? @"" : self.players[row][kCommentKey];
    [self.statsTable reloadData];
}

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
    
    int playerIndex = 0;
    for (int i = 0; i < [self.players count]; i ++)
    {
        NSString *playerName = self.playerText.text;
        NSDictionary *playerInfo = self.players[i];
        if ([playerInfo[kNameKey] isEqualToString:playerName])
        {
            playerIndex = i;
            break;
        }
        
        if (i == [self.players count]-1)//没有找到该球员名字
            playerIndex = -1;
    }
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
    
    if ([self.players count] == 0)
    {
        titleLabel.text = @"";
        detailLabel.text = @"";
        return cell;
    }
    
    switch (indexPath.row) {
        case 0:
            titleLabel.text = @"总得分";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kScoreKey]];
            break;
        case 1:
            titleLabel.text = @"二分球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                                            players[playerIndex][kStatsKey][k2PointShootKey],
                                                            players[playerIndex][kStatsKey][k2PointGoalKey],
                                [(NSNumber *)players[playerIndex][kStatsKey][k2PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)players[playerIndex][kStatsKey][k2PointGoalKey] floatValue] / [(NSNumber *)players[playerIndex][kStatsKey][k2PointShootKey] floatValue] * 100];
            break;
        case 2:
            titleLabel.text = @"三分球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                players[playerIndex][kStatsKey][k3PointShootKey],
                                players[playerIndex][kStatsKey][k3PointGoalKey],
                                [(NSNumber *)players[playerIndex][kStatsKey][k3PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)players[playerIndex][kStatsKey][k3PointGoalKey] floatValue] / [(NSNumber *)players[playerIndex][kStatsKey][k3PointShootKey] floatValue] * 100];
            break;
        case 3:
            titleLabel.text = @"罚球";
            detailLabel.text = [NSString stringWithFormat:@"%@投 %@中 %.1f%%",
                                players[playerIndex][kStatsKey][k1PointShootKey],
                                players[playerIndex][kStatsKey][k1PointGoalKey],
                                [(NSNumber *)players[playerIndex][kStatsKey][k1PointShootKey] intValue] == 0 ? 0.0 : [(NSNumber *)players[playerIndex][kStatsKey][k1PointGoalKey] floatValue] / [(NSNumber *)players[playerIndex][kStatsKey][k1PointShootKey] floatValue] * 100];
            break;
        case 4:
            titleLabel.text = @"篮板";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kReboundKey]];
            break;
        case 5:
            titleLabel.text = @"助攻";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kAssistKey]];
            break;
        case 6:
            titleLabel.text = @"抢断";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kStealKey]];
            break;
        case 7:
            titleLabel.text = @"盖帽";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kBlockKey]];
            break;
        case 8:
            titleLabel.text = @"犯规";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kFoulKey]];
            break;
        case 9:
            titleLabel.text = @"失误";
            detailLabel.text = [NSString stringWithFormat:@"%@", players[playerIndex][kStatsKey][kFaultKey]];
            break;
        default:
            break;
    }
    
    return cell;
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
