//
//  FISCustomPugCell.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/29/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISCustomPugCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *pugCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *pugCellCustomLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageImageView;
@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;

@end
