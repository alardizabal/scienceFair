//
//  MPSProfileViewController.h
//  MakersFindersUserProfile
//
//  Created by matt on 7/30/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MFUser.h"

@import UIKit;
@interface MPSProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UILabel *profileJobTitle;
@property (strong, nonatomic) NSMutableArray *layouts;
@property (strong, nonatomic)MFUser *user;
@property (strong, nonatomic) UIImageView *defaultImageView;

- (IBAction)followButton:(id)sender;



-(void)setImages: (NSMutableArray *)images forView:(UIView *)view;

-(void)setUsersFindImages: (NSMutableArray *)userFindImages;


@end
