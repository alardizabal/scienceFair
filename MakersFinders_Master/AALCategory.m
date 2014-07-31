//
//  AALInterests.m
//  InterestsScrollView
//
//  Created by Albert Lardizabal on 7/29/14.
//  Copyright (c) 2014 Albert Lardizabal. All rights reserved.
//

#import "AALCategory.h"

@implementation AALCategory

- (instancetype)init
{
    return [self initWithCategoryName:@"" categoryImage:nil interests:nil];
}

- (instancetype)initWithCategoryName:(NSString *)categoryName
                       categoryImage:(UIImage *)categoryImage
                           interests:(NSArray *)interests
{
    self = [super init];
    if (self) {
        _categoryName = categoryName;
        _categoryImage = categoryImage;
        _interests = interests;
    }
    return self;
}

@end
