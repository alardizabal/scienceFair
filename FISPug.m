//
//  FISPug.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISPug.h"

@implementation FISPug

-(instancetype)init
{
    return [self initPugWithImage:[UIImage new]]; 
}

-(instancetype)initPugWithImage:(UIImage *)imageOfPug
{
    self = [super init];

    if (self) {
        _pugImage = imageOfPug;
    }
    return self;
}

@end
