//
//  RCLiveRecordViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCLiveRecordViewController.h"
#import "RCAddMatchViewController.h"
#import "BFPaperButton.h"

@interface RCLiveRecordViewController ()

@end

@implementation RCLiveRecordViewController

@synthesize statsArray, players, actions;

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
    self.addRecordBtn.backgroundColor = [UIColor whiteColor];
    self.statsArray = [NSMutableArray arrayWithContentsOfFile:[self dataFilePath]];
    
    RCTeam *team = [[RCTeam alloc] init];
    self.players = [team players];
    self.actions = [NSArray arrayWithObjects:@"二分命中", @"二分未中", @"三分命中", @"三分未中", @"罚球命中", @"罚球未中", @"篮板", @"助攻", @"抢断",@"盖帽", @"犯规", @"失误", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
        return [self.players count];
    else
        return [self.actions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
        return self.players[row][kNameKey];
    else
        return self.actions[row];
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.statsArray removeObjectAtIndex:indexPath.row]; // Delete the row from the data source.
        [self.statsTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.statsTable reloadData];
    }
}

- (IBAction)addOneRecord:(id)sender
{
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"HH:mm:ss";
    NSString *timeString = [f stringFromDate:[NSDate date]];
    int playerRow = (int)[self.picker selectedRowInComponent:0];
    int actionRow = (int)[self.picker selectedRowInComponent:1];
    NSDictionary *aRecord = [NSDictionary dictionaryWithObjectsAndKeys:
                             timeString, kTimeKey,
                             self.players[playerRow][kNameKey], kNameKey,
                             self.actions[actionRow], kActionKey, nil];
    [self.statsArray insertObject:aRecord atIndex:0];
    [self.statsTable reloadData];
}

- (void)save:(id)sender
{
    [self.statsArray writeToFile:[self dataFilePath] atomically:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
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
