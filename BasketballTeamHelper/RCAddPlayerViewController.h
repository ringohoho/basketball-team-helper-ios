//
//  RCAddPlayerViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-23.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@class RCTextFieldWithPicker;

@interface RCAddPlayerViewController : RCViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet RCTextFieldWithPicker *positionText;
@property (weak, nonatomic) IBOutlet UITextView *commentText;
@property (strong, nonatomic) UIPickerView *positionPicker;
@property (strong, nonatomic) NSArray *positions;

@end
