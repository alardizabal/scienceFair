//
//  MFAPIClient.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFAPIClient : NSObject
+(void)createNewUserWithName:(NSString *)name Email:(NSString *)email Password:(NSString *)password PasswordConfirmation:(NSString *)passwordConfirmation Completion:(void (^)(id responseObject))completionBlock;

+(void)loginNewUserWithEmail:(NSString *)email Password:(NSString *)password  Completion:(void (^)(id responseObject))completionBlock;

+ (void) getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock;

+(void)retrieveFeedAPIImages:(void (^)(BOOL success, NSArray *responseObjectArray))completionHandler;

+(void)getUserProfiles:(void (^)(NSDictionary *))completionBlock;

+ (void) getUserInterestsWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock;

+(void)getInterestFeedItemForIdNumber:(NSNumber *)uniqueIDNumber WithCompletion:(void (^)(NSArray *items))completionBlock;

@end
