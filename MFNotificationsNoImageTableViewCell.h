//
//  MFNotificationsNoImageTableViewCell.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/12/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MFNotificationsNoImageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeStampLabel;


@end
