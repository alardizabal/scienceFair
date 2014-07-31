//
//  FISCollectionLandscapeViewController.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/30/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FISDataStore;

@interface FISCollectionLandscapeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *myCollectionView;
@property (strong, nonatomic) FISDataStore *store;

@end
