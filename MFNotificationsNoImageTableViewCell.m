//
//  MFNotificationsNoImageTableViewCell.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/12/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFNotificationsNoImageTableViewCell.h"

@implementation MFNotificationsNoImageTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.profileImage.image = [UIImage imageNamed:@"placeholder"];
    self.userLabel.text = @"";
    self.infoLabel.text = @"";
    self.timeStampLabel.text = @"";
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.layer.masksToBounds = YES;
    
    self.userLabel.textColor = MFtealColor;
    self.infoLabel.textColor = [UIColor grayColor];
    self.timeStampLabel.textColor = [UIColor grayColor];
    self.userLabel.font = MFhelvetica;
    self.infoLabel.font = MFhelveticaNotifications;
    self.timeStampLabel.font = MFhelveticaNotifications;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
