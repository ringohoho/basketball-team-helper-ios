//
//  RCSettingsTableViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 10/2/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCSettingsTableViewController.h"
#import "RCHelper.h"

@interface RCSettingsTableViewController ()

@end

@implementation RCSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)provideFeedback
{
    @try {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        [mailController setSubject:@"篮球队助手 意见反馈"];
        [mailController setToRecipients:[NSArray arrayWithObject:@"feedback@r-c.im"]];
        [self presentViewController:mailController animated:YES completion:nil];
    }
    @catch(NSException *ex) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"操作失败"
                                                        message:@"您的系统中没有设置邮件地址，暂时无法发送意见反馈。请在系统中添加邮件地址后再试。"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (void)rateOnAppStore
{
    NSString *str = [NSString stringWithFormat:@"https://itunes.apple.com/us/app/lan-qiu-dui-zhu-shou/id%d?ls=1&mt=8", APP_ID];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:str]];
}

- (void)clearAllData
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
}

- (void)clearAllDataConfirm
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"清空所有数据"
                                                    message:@"你确定要继续？这将会清空你所记录的所有数据，应用将恢复到初始状态！"
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"清空数据", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != alertView.cancelButtonIndex)
    {
        [self clearAllData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section == 0) // 'Data' section
    {
        if (indexPath.row == 0) // Clear all data
        {
            [self clearAllDataConfirm];
        }
    }
    else // 'Other' section
    {
        if (indexPath.row == 0) // Feedback
        {
            [self provideFeedback];
        }
        else // Rate on App Store
        {
            [self rateOnAppStore];
        }
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
