//
//  RCMatchesMasterViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCMatchesMasterViewController.h"
#import "RCMatchDetailViewController.h"

@interface RCMatchesMasterViewController ()

@end

@implementation RCMatchesMasterViewController

@synthesize matches;

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
    self.matches = [team matches];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.matchesTable deselectRowAtIndexPath:[self.matchesTable indexPathForSelectedRow] animated:YES];
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
    return [self.matches count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MatchCellID = @"Match Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MatchCellID];
    
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:1];
    UILabel *subtitleLabel = (UILabel *)[cell viewWithTag:2];
    
    titleLabel.text = self.matches[indexPath.row][kTitleKey];
    subtitleLabel.text = self.matches[indexPath.row][kDateKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RCMatchDetailViewController *nextVC = segue.destinationViewController;
    int selectedRow = (int)[self.matchesTable indexPathForSelectedRow].row;
    nextVC.selectedRow = selectedRow;
    nextVC.title = self.matches[selectedRow][kTitleKey];
}


@end
