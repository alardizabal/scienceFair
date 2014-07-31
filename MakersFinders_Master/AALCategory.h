//
//  AALInterests.h
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AALInterest.h"

@interface AALCategory : NSObject

@property (nonatomic) NSString *categoryName;
@property (nonatomic) UIImage *categoryImage;
@property (nonatomic) NSArray *interests;

- (instancetype)init;
- (instancetype)initWithCategoryName:(NSString *)categoryName
                       categoryImage:(UIImage *)categoryImage
                           interests:(NSArray *)interests;

@end
