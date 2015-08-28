//
//  RCTeam.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString *kMatchesKey;
NSString *kStatsKey;
NSString *kDateKey;
NSString *kTimeKey;
NSString *kTitleKey;
NSString *kNameKey;
NSString *kActionKey;
NSString *kCommentKey;
NSString *kPlayersKey;
NSString *kPositionKey;
NSString *kScoreKey;
NSString *k1PointShootKey;
NSString *k1PointGoalKey;
NSString *k2PointShootKey;
NSString *k2PointGoalKey;
NSString *k3PointShootKey;
NSString *k3PointGoalKey;
NSString *kReboundKey;
NSString *kAssistKey;
NSString *kStealKey;
NSString *kBlockKey;
NSString *kFoulKey;
NSString *kFaultKey;

@interface RCTeam : NSObject

@property (nonatomic, copy) NSDictionary *info;

+ (NSDictionary *)matchAsStatsWithMatch:(NSDictionary *)match;

- (NSString *)name;
- (void)setName:(NSString *)name;
- (NSString *)comment;
- (void)setComment:(NSString *)comment;
- (void)addPlayer:(NSString *)name inPosition: (NSString *)pos withComment: (NSString *)comment;
- (void)setPlayers:(NSArray *)players;
- (NSArray *)players;
- (int)indexOfPlayer:(NSString *)name;
- (void)addMatch:(NSString *)title atDate:(NSDate *)date withStats:(NSArray *)stats andComment:(NSString *)comment;
- (NSDictionary *)stats;
- (NSArray *)matches;
- (NSDictionary *)mactchAsStatsAtIndex:(NSInteger)index;
- (void)setMatch:(NSDictionary *)match atIndex:(NSInteger)index;

@end
