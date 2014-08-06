//
//  MFNotificationsTableViewCell.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFNotificationsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIImageView *imageOne;
@property (weak, nonatomic) IBOutlet UIImageView *imageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *imageThree;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
