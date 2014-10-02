//
//  RCHelper.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFileName @"TeamInfo.plist"

#define DEFAULT_TINT_COLOR [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0]
#define DEFAULT_LIGHT_BLUE_COLOR [UIColor colorWithRed:102.0/255.0 green:204.0/255.0 blue:255.0/255.0 alpha:1.0]
#define DEFAULT_LIGHT_GREEN_COLOR [UIColor colorWithRed:102.0/255.0 green:255.0/255.0 blue:204.0/255.0 alpha:1.0]

#define APP_ID 887454357

@interface RCHelper : NSObject

+ (NSString *)dataFilePath;

@end
