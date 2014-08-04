//
//  AALAPIClient.h
//  MakersFinders_Master
//
//  Created by Albert Lardizabal on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AALAPIClient : NSObject

+ (void) getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock;

@end
