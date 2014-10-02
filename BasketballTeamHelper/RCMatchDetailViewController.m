//
//  RCMatchDetailViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCMatchDetailViewController.h"

@interface RCMatchDetailViewController ()

@end

@implementation RCMatchDetailViewController

@synthesize selectedRow, match, matchStats;

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
    RCTeam *team = [[RCTeam alloc] init];
    self.match = [team matches][selectedRow];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.matchStats count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *RecordCellID = @"Record Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:RecordCellID];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:2];
    
    NSDictionary *aRecord = self.matchStats[indexPath.row];
    subtitleLabel.text = [NSString stringWithFormat:@"%@", aRecord[kTimeKey]];
    titleLabel.text = [NSString stringWithFormat:@"%@ %@", aRecord[kNameKey], aRecord[kActionKey]];
    
    return cell;
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
