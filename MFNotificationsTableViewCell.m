//
//  MFNotificationsTableViewCell.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFNotificationsTableViewCell.h"

@implementation MFNotificationsTableViewCell

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
    self.imageOne.image = [UIImage imageNamed:@"placeholder"];
    self.imageTwo.image = [UIImage imageNamed:@"placeholder"];
    self.imageThree.image = [UIImage imageNamed:@"placeholder"];
    self.nameLabel.text = @"";
    self.infoLabel.text = @"";
    self.timeStampLabel.text = @"";
    
    self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2;
    self.profileImage.layer.masksToBounds = YES;
    
    self.nameLabel.textColor = MFtealColor;
    self.infoLabel.textColor = [UIColor grayColor];
    self.timeStampLabel.textColor = [UIColor grayColor];
    self.nameLabel.font = MFhelvetica;
    self.infoLabel.font = MFhelveticaNotifications;
    self.timeStampLabel.font = MFhelveticaNotifications;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
