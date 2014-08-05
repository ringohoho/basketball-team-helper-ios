//
//  RCMatchesMasterViewController.h
//  BasketballTeamHelper
//
//  Created by Richard Chien on 6/9/14.
//  Copyright (c) 2014 Richard Chien. All rights reserved.
//

#import "RCViewController.h"

@interface RCMatchesMasterViewController : RCViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *matchesTable;
@property (strong, nonatomic) NSArray *matches;

@end
