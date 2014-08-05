//
//  RCViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-12.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCViewController.h"
#import "RCToolbar.h"

@interface RCViewController ()

@end

@implementation RCViewController

@synthesize inputAccessoryBar;

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
    inputAccessoryBar = [[RCToolbar alloc] init];
    inputAccessoryBar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)save:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIResponder *)findFirstResponder
{
    for (UIView *subView in self.view.subviews) {
        if (subView.isFirstResponder
            && ([subView isKindOfClass:[UITextField class]] || [subView isKindOfClass:[UITextView class]])) {
            return (UIResponder *)subView;
        }
    }
    
    return nil;
}

@end
