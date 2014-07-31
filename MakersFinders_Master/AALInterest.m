//
//  AALSubCategory.m
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALInterest.h"

@implementation AALInterest

- (instancetype)init
{
    return [self initWithInterestName:@"" interestImage:nil];
}

- (instancetype)initWithInterestName:(NSString *)interestName
                       interestImage:(UIImage *)interestImage
{
    self = [super init];
    if (self) {
        _interestName = interestName;
        _interestImage = interestImage;
    }
    return self;
}

@end
