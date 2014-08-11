//
//  MFBackground.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFBackground : NSObject

+(void)LoadCategoryAndInterestImagesInBackGround;
+(void)getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock;
+(void)saveImage: (UIImage*)image WithName:(NSString *)name;
+(NSString *)getNameOfImageURLWithName: (NSString *)name; 

@end
