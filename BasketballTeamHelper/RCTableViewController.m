//
//  RCTableViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 10/2/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCTableViewController.h"

@interface RCTableViewController ()

@end

@implementation RCTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
