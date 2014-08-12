//
//  FISCustomPugCell.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISCustomPugCell.h"

@implementation FISCustomPugCell

- (void)awakeFromNib
{
    //For optimization purposes, all images need to be circular 
    self.profileImageImageView.layer.cornerRadius = 25.0;
    self.profileImageImageView.layer.borderWidth = 1.0;
    self.profileImageImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.profileImageImageView.layer.masksToBounds = YES;
    
    self.profileImageImageView.image = [UIImage imageNamed:@"placeholder.png"];
    self.pugCellCustomLabel.alpha = 0.4;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected) {
        self.pugCellCustomLabel.backgroundColor = [UIColor colorWithRed:97.0/255.0 green:188.0/255.0 blue:248.0/255.0 alpha:0.7];
    }
}

@end
