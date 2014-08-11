//
//  FISProductDetailViewController.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MFItem;

@interface FISProductDetailViewController : UIViewController

@property (strong, nonatomic) NSString *urlStringOfImage;
@property (strong, nonatomic) MFItem *currentItem;

@end
