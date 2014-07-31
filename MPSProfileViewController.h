//
//  MPSProfileViewController.h
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UIKit;
@interface MPSProfileViewController : UIViewController

//property for the profile image view
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UIImageView *blurredUserHeader;

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;


@end
