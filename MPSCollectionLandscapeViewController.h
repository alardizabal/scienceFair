//
//  MPSCollectionLandscapeViewController.h
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPSCollectionLandscapeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *myCollectionView;

@end
