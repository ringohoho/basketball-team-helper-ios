//
//  RCHelper.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kFileName @"TeamInfo.plist"

#define DEFAULT_TINT_COLOR [UIColor colorWithRed:255 green:0 blue:0 alpha:1]

@interface RCHelper : NSObject

+ (NSString *)dataFilePath;

@end
