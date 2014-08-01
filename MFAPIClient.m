//
//  MFAPIClient.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFAPIClient.h"

@implementation MFAPIClient

-(void)createNewUserWithName:(NSString *)name Email:(NSString *)email Password:(NSString *)password PasswordConfirmation:(NSString *)passwordConfirmation Completion:(void (^)())completionBlock
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        NSString *createUserURLString = [NSString stringWithFormat:@"%@", kUSER_CREATE_URL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"user[name]":name, @"user[email]":email, @"user[password]": password, @"user[password_confirmation]":passwordConfirmation};
        
        [manager POST:createUserURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            completionBlock();
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error signing up, %@",error);
        }];
    }];
}

-(void)loginNewUserWithEmail:(NSString *)email Password:(NSString *)password  Completion:(void (^)())completionBlock;
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        NSString *loginUserURLString = [NSString stringWithFormat:@"%@", kUSER_LOGIN_URL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"session[email]":email, @"session[password]":password};
        
        [manager POST:loginUserURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            completionBlock();
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error signing up, %@",error);
        }];
    }];
}
@end


