//
//  AALSubCategory.h
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AALInterest : NSObject

@property (nonatomic) NSString *interestName;
@property (nonatomic) UIImage *interestImage;

- (instancetype)init;
- (instancetype)initWithInterestName:(NSString *)interestName
                       interestImage:(UIImage *)interestImage;

@end
