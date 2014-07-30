//
//  FISPug.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISPug : NSObject

@property (strong, nonatomic) UIImage *pugImage;

-(instancetype)init;
-(instancetype)initPugWithImage:(UIImage *)imageOfPug; 

@end
