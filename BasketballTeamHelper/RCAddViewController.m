//
//  RCAddViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 8/5/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCAddViewController.h"
#import "RCHelper.h"
#import "BFPaperButton.h"

@interface RCAddViewController ()

@end

@implementation RCAddViewController

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
    self.addPlayerBtn.backgroundColor = DEFAULT_LIGHT_BLUE_COLOR;
    self.addPlayerBtn.cornerRadius = self.addPlayerBtn.frame.size.width / 2;
    self.addPlayerBtn.rippleFromTapLocation = NO;
    self.addPlayerBtn.rippleBeyondBounds = YES;
    self.addPlayerBtn.tapCircleDiameter = MAX(self.addPlayerBtn.frame.size.width, self.addPlayerBtn.frame.size.height) * 1.5;
    self.addMatchBtn.backgroundColor = DEFAULT_LIGHT_GREEN_COLOR;
    self.addMatchBtn.cornerRadius = self.addMatchBtn.frame.size.width / 2;
    self.addMatchBtn.rippleFromTapLocation = NO;
    self.addMatchBtn.rippleBeyondBounds = YES;
    self.addMatchBtn.tapCircleDiameter = MAX(self.addMatchBtn.frame.size.width, self.addMatchBtn.frame.size.height) * 1.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"Add Match Segue"])
    {
        RCTeam *team = [[RCTeam alloc] init];
        NSArray *players = [team players];
        if ([players count] == 0)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"您还没有添加过球员哦～"
                                                            message:@"请先到“添加球员”页面去添加几个球员再比赛吧！"
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
    
}
*/

@end
