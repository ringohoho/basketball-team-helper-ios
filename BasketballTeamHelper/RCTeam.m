//
//  RCTeam.m
//  BasketballTeamHelper
//
//  Created by Richard Chien on 14-5-21.
//  Copyright (c) 2014年 Richard Chien. All rights reserved.
//

#import "RCTeam.h"
#import "RCHelper.h"

NSString *kMatchesKey = @"matches";
NSString *kStatsKey = @"stats";
NSString *kDateKey = @"date";
NSString *kTimeKey = @"time";
NSString *kTitleKey = @"title";
NSString *kNameKey = @"name";
NSString *kActionKey = @"action";
NSString *kCommentKey = @"comment";
NSString *kPlayersKey = @"players";
NSString *kPositionKey = @"position";
NSString *kScoreKey = @"score";
NSString *k1PointShootKey = @"1pShoot";
NSString *k1PointGoalKey = @"1pGoal";
NSString *k2PointShootKey = @"2pShoot";
NSString *k2PointGoalKey = @"2pGoal";
NSString *k3PointShootKey = @"3pShoot";
NSString *k3PointGoalKey = @"3pGoal";
NSString *kReboundKey = @"rebound";
NSString *kAssistKey = @"assist";
NSString *kStealKey = @"steal";
NSString *kBlockKey = @"block";
NSString *kFoulKey = @"foul";
NSString *kFaultKey = @"fault";

@interface RCTeam ()

@end

@implementation RCTeam

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *filePath = [RCHelper dataFilePath];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
            _info = [NSDictionary dictionaryWithContentsOfFile:filePath];
        else
        {
            NSDictionary *stats = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:0], kScoreKey,
                                   [NSNumber numberWithInt:0], k1PointShootKey,
                                   [NSNumber numberWithInt:0], k1PointGoalKey,
                                   [NSNumber numberWithInt:0], k2PointShootKey,
                                   [NSNumber numberWithInt:0], k2PointGoalKey,
                                   [NSNumber numberWithInt:0], k3PointShootKey,
                                   [NSNumber numberWithInt:0], k3PointGoalKey,
                                   [NSNumber numberWithInt:0], kReboundKey,
                                   [NSNumber numberWithInt:0], kAssistKey,
                                   [NSNumber numberWithInt:0], kStealKey,
                                   [NSNumber numberWithInt:0], kBlockKey,
                                   [NSNumber numberWithInt:0], kFoulKey,
                                   [NSNumber numberWithInt:0], kFaultKey, nil];
            _info = [NSDictionary dictionaryWithObjectsAndKeys:
                     @"未命名球队", kNameKey,
                     @"", kCommentKey,
                     stats, kStatsKey,
                     [NSMutableArray array], kPlayersKey,
                     [NSMutableArray array], kMatchesKey, nil];
            [_info writeToFile:filePath atomically:YES];
        }
    }
    return self;
}

- (NSString *)name
{
    return self.info[kNameKey];
}

- (void)setName:(NSString *)name
{
    [self.info setValue:name forKey:kNameKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

- (NSString *)comment
{
    return self.info[kCommentKey];
}

- (void)setComment:(NSString *)comment;
{
    [self.info setValue:comment forKey:kCommentKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

- (void)addPlayer:(NSString *)name inPosition: (NSString *)pos withComment: (NSString *)comment
{
    NSMutableArray *players = self.info[kPlayersKey];
    NSDictionary *playerStats = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithInt:0], kScoreKey,
                                 [NSNumber numberWithInt:0], k1PointShootKey,
                                 [NSNumber numberWithInt:0], k1PointGoalKey,
                                 [NSNumber numberWithInt:0], k2PointShootKey,
                                 [NSNumber numberWithInt:0], k2PointGoalKey,
                                 [NSNumber numberWithInt:0], k3PointShootKey,
                                 [NSNumber numberWithInt:0], k3PointGoalKey,
                                 [NSNumber numberWithInt:0], kReboundKey,
                                 [NSNumber numberWithInt:0], kAssistKey,
                                 [NSNumber numberWithInt:0], kStealKey,
                                 [NSNumber numberWithInt:0], kBlockKey,
                                 [NSNumber numberWithInt:0], kFoulKey,
                                 [NSNumber numberWithInt:0], kFaultKey, nil];
    NSDictionary *playerInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                                name, kNameKey,
                                pos, kPositionKey,
                                comment, kCommentKey,
                                playerStats, kStatsKey, nil];
    if ([players count] == 0)
        players = [NSMutableArray arrayWithObject:playerInfo];
    else
        [players addObject:playerInfo];
    [self.info setValue:players forKey:kPlayersKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

- (void)setPlayers:(NSArray *)players
{
    [self.info setValue:players forKey:kPlayersKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

- (NSArray *)players
{
    return self.info[kPlayersKey];
}

- (int)indexOfPlayer:(NSString *)name
{
    int playerIndex = 0;
    NSMutableArray *players = self.info[kPlayersKey];
    for (int i = 0; i < [players count]; i ++)
    {
        NSDictionary *playerInfo = self.players[i];
        if ([playerInfo[kNameKey] isEqualToString:name])
        {
            playerIndex = i;
            break;
        }
        if (i == [self.players count]-1)//没有找到该球员名字
        {
            playerIndex = -1;
            break;
        }
    }
    return playerIndex;
}

- (void)addMatch:(NSString *)title atDate:(NSDate *)date withStats:(NSArray *)stats andComment:(NSString *)comment
{
    NSMutableArray *players = self.info[kPlayersKey];
    NSDictionary *teamStats = self.info[kStatsKey];
    
    for (NSDictionary *aRecord in stats)
    {
        int playerIndex = [self indexOfPlayer:aRecord[kNameKey]];
        NSDictionary *playerStats = players[playerIndex][kStatsKey];
        NSString *action = aRecord[kActionKey];
        if ([action isEqualToString:@"二分未中"])
        {
            int n = [playerStats[k2PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k2PointShootKey];
            
            n = [teamStats[k2PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k2PointShootKey];
        }
        else if ([action isEqualToString:@"二分命中"])
        {
            int n = [playerStats[k2PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k2PointShootKey];
            n = [playerStats[k2PointGoalKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k2PointGoalKey];
            
            n = [teamStats[k2PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k2PointShootKey];
            n = [teamStats[k2PointGoalKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k2PointGoalKey];
        }
        else if ([action isEqualToString:@"三分未中"])
        {
            int n = [playerStats[k3PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k3PointShootKey];
            
            n = [teamStats[k3PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k3PointShootKey];
        }
        else if ([action isEqualToString:@"三分命中"])
        {
            int n = [playerStats[k3PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k3PointShootKey];
            n = [playerStats[k3PointGoalKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k3PointGoalKey];
            
            n = [teamStats[k3PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k3PointShootKey];
            n = [teamStats[k3PointGoalKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k3PointGoalKey];
        }
        else if ([action isEqualToString:@"罚球未中"])
        {
            int n = [playerStats[k1PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k1PointShootKey];
            
            n = [teamStats[k1PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k1PointShootKey];
        }
        else if ([action isEqualToString:@"罚球命中"])
        {
            int n = [playerStats[k1PointShootKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k1PointShootKey];
            n = [playerStats[k1PointGoalKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:k1PointGoalKey];
            
            n = [teamStats[k1PointShootKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k1PointShootKey];
            n = [teamStats[k1PointGoalKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:k1PointGoalKey];
        }
        else if ([action isEqualToString:@"篮板"])
        {
            int n = [playerStats[kReboundKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kReboundKey];
            
            n = [teamStats[kReboundKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kReboundKey];
        }
        else if ([action isEqualToString:@"助攻"])
        {
            int n = [playerStats[kAssistKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kAssistKey];
            
            n = [teamStats[kAssistKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kAssistKey];
        }
        else if ([action isEqualToString:@"抢断"])
        {
            int n = [playerStats[kStealKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kStealKey];
            
            n = [teamStats[kStealKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kStealKey];
        }
        else if ([action isEqualToString:@"盖帽"])
        {
            int n = [playerStats[kBlockKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kBlockKey];
            
            n = [teamStats[kBlockKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kBlockKey];
        }
        else if ([action isEqualToString:@"犯规"])
        {
            int n = [playerStats[kFoulKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kFoulKey];
            
            n = [teamStats[kFoulKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kFoulKey];
        }
        else if ([action isEqualToString:@"失误"])
        {
            int n = [playerStats[kFaultKey] intValue];
            n ++;
            [playerStats setValue:[NSNumber numberWithInt:n] forKey:kFaultKey];
            
            n = [teamStats[kFaultKey] intValue];
            n ++;
            [teamStats setValue:[NSNumber numberWithInt:n] forKey:kFaultKey];
        }
        
        int p1Goal = [playerStats[k1PointGoalKey] intValue];
        int p2Goal = [playerStats[k2PointGoalKey] intValue];
        int p3Goal = [playerStats[k3PointGoalKey] intValue];
        int score = p1Goal + 2 * p2Goal + 3 * p3Goal;
        [playerStats setValue:[NSNumber numberWithInt:score] forKey:kScoreKey];
        [players[playerIndex] setValue:playerStats forKey:kStatsKey];
    }
    
    int p1Goal = [teamStats[k1PointGoalKey] intValue];
    int p2Goal = [teamStats[k2PointGoalKey] intValue];
    int p3Goal = [teamStats[k3PointGoalKey] intValue];
    int score = p1Goal + 2 * p2Goal + 3 * p3Goal;
    [teamStats setValue:[NSNumber numberWithInt:score] forKey:kScoreKey];
    [self.info setValue:players forKey:kPlayersKey];
    [self.info setValue:teamStats forKey:kStatsKey];
    
    NSMutableArray *matches = self.info[kMatchesKey];
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    f.dateFormat = @"yy/MM/dd";
    NSString *dateString = [f stringFromDate:date];
    NSDictionary *matchInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                               title, kTitleKey,
                               dateString, kDateKey,
                               comment, kCommentKey,
                               stats, kStatsKey, nil];
    
    if ([matches count] == 0)
        matches = [NSMutableArray arrayWithObject:matchInfo];
    else
        [matches insertObject:matchInfo atIndex:0];
    
    [self.info setValue:matches forKey:kMatchesKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

- (NSDictionary *)stats
{
    return self.info[kStatsKey];
}

- (NSArray *)matches
{
    return self.info[kMatchesKey];
}

- (void)setMatch:(NSDictionary *)match atIndex:(NSInteger)index
{
    NSMutableArray *matches = [NSMutableArray arrayWithArray:[self matches]];
    matches[index] = match;
    [self.info setValue:matches forKey:kMatchesKey];
    [self.info writeToFile:[RCHelper dataFilePath] atomically:YES];
}

@end
