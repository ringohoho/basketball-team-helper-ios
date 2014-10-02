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

@interface RCAddMatchViewController ()

@end

@implementation RCAddMatchViewController

@synthesize statsArray;

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.statsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *StatsCellID = @"Record Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:StatsCellID];
    int row = (int)indexPath.row;
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:2];
    
    subtitleLabel.text = [NSString stringWithFormat:@"%@", self.statsArray[row][kTimeKey]];
    titleLabel.text = [NSString stringWithFormat:@"%@ %@", self.statsArray[row][kNameKey], self.statsArray[row][kActionKey]];
    
    return cell;
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
