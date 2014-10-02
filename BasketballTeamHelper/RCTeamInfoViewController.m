//
//  RCTeamInfoViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-22.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCTeamInfoViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RCTeamInfoViewController ()

@end

@implementation RCTeamInfoViewController

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
    self.nameText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.commentText.layer.borderWidth = 0.3;
    self.commentText.layer.cornerRadius = 5.0;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    RCTeam *team = [[RCTeam alloc] init];
    self.nameText.text = [team name];
    self.commentText.text = [team comment];
    [self.nameText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender
{
    if ([self.nameText.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"球队名可不能为空哦～"
                                                        message:@"至少先给球队起个响亮的名字再保存吧！"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    RCTeam *team = [[RCTeam alloc] init];
    [team setName:self.nameText.text];
    [team setComment:self.commentText.text];
    
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
