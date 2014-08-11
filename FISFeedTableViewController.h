//
//  FISFeedTableViewController.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFDataStore;
@class MFItem; 

@interface FISFeedTableViewController : UITableViewController

@property (strong, nonatomic) MFDataStore *store;

@property (strong, nonatomic) NSMutableArray *arrayOfFeedImages;
@property (strong, nonatomic) NSMutableArray *arrayOfItemsObjects;
@property (strong, nonatomic) NSString *stringOfURLOfImages;

@end
