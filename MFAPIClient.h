//
//  MFAPIClient.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MFAPIClient : NSObject
-(void)createNewUserWithName:(NSString *)name Email:(NSString *)email Password:(NSString *)password PasswordConfirmation:(NSString *)passwordConfirmation Completion:(void (^)(id responseObject))completionBlock;

-(void)loginNewUserWithEmail:(NSString *)email Password:(NSString *)password  Completion:(void (^)())completionBlock;

+ (void) getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock;

@end
