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
    self.nameLabel.text = @"Daniel Sun";
    self.infoLabel.text = @"liked three Makes";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
