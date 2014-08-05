//
//  RCAddPlayerViewController.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-23.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCAddPlayerViewController.h"
#import "RCTextFieldWithPicker.h"

@interface RCAddPlayerViewController ()

@end

@implementation RCAddPlayerViewController

@synthesize positionPicker, positions;

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
    self.positions = [NSArray arrayWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"Positions.plist"]];
    self.positionText.text = self.positions[0];
    self.positionPicker = [[UIPickerView alloc] init];
    self.positionPicker.backgroundColor = [UIColor whiteColor];
    self.positionPicker.dataSource = self;
    self.positionPicker.delegate = self;
    self.positionText.inputView = self.positionPicker;
    self.positionText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    
    self.nameText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
    self.commentText.inputAccessoryView = (UIView *)self.inputAccessoryBar;
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
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"球员名字可不能为空哦～"
                                                        message:@"至少把球员的名字填上再保存吧！"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    RCTeam *team = [[RCTeam alloc] init];
    [team addPlayer:self.nameText.text inPosition:self.positionText.text withComment:self.commentText.text];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.positions count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.positions[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.positionText.text = self.positions[row];
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
