//
//  MFAPIClient.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFAPIClient.h"
#import "MFUser.h"

@implementation MFAPIClient

+(void)createNewUserWithName:(NSString *)name Email:(NSString *)email Password:(NSString *)password PasswordConfirmation:(NSString *)passwordConfirmation Completion:(void (^)(id responseObject))completionBlock
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        NSString *createUserURLString = [NSString stringWithFormat:@"%@", kUSER_CREATE_URL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"user[name]":name, @"user[email]":email, @"user[password]": password, @"user[password_confirmation]":passwordConfirmation};
        
        [manager POST:createUserURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            completionBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error signing up, %@",error.localizedDescription);
        }];
    }];
}

+(void)loginNewUserWithEmail:(NSString *)email Password:(NSString *)password  Completion:(void (^)(id responseObject))completionBlock;
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    [backgroundQueue addOperationWithBlock:^{
        NSString *loginUserURLString = [NSString stringWithFormat:@"%@", kUSER_LOGIN_URL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        
        NSDictionary *params = @{@"session[email]":email, @"session[password]":password};
        
        [manager POST:loginUserURLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            completionBlock(responseObject);
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            NSLog(@"Error signing up, %@",error.localizedDescription);
            NSDictionary *errorResponse = @{@"error":error};
            completionBlock(errorResponse);
            }];
    }];
}

+ (void) getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock {
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *getCategoryImagesURL = [NSString stringWithFormat:@"%@", kCATEGORY_API_URL];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getCategoryImagesURL
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

+(void)getUserProfiles:(void (^)(NSDictionary *))completionBlock
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    
    MFUser *currentUser = [MFUser currentUser];
    NSString *getUserProfile = [NSString stringWithFormat:@"%@%@", kUSER_PROFILE_API_URL, currentUser.uniqueID];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getUserProfile
      parameters:nil
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
    
}

+ (void) getUserInterestsWithCompletion:(void (^)(NSArray *array))completionBlock {
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *getUserInterests = [NSString stringWithFormat:@"%@", kCREATE_UPDATE_INTERESTS_URL];
    
    MFUser *currentUser = [MFUser currentUser];
    
    NSDictionary *params = @{@"token": currentUser.token};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:getUserInterests
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             completionBlock(responseObject);
         }];
         
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}

+ (void) createUserInterest:(NSString *)interestIndices
                 completion:(void (^)(void))completionBlock {
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *postUserInterests = [NSString stringWithFormat:@"%@", kCREATE_UPDATE_INTERESTS_URL];
    
    MFUser *currentUser = [MFUser currentUser];
    
    NSDictionary *params = @{@"token": currentUser.token, @"interests[ids]":interestIndices};
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager POST:postUserInterests
      parameters:params
         success:^(NSURLSessionDataTask *task, id responseObject)
     {
         [backgroundQueue addOperationWithBlock:^{
             completionBlock();
         }];
         
         NSLog(@"%@", responseObject);
         
     } failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         NSLog(@"Fail: %@",error.localizedDescription);
     }];
}


+(void)retrieveFeedAPIImages:(void (^)(BOOL, NSArray *))completionHandler
{
    NSOperationQueue *separateQueue = [[NSOperationQueue alloc] init];
    
    NSURL *feedAPIURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@token=%@", kFEED_API_URL, [MFUser currentUser].token]];
    
    NSURLRequest *feedAPIURLRequest = [[NSURLRequest alloc] initWithURL:feedAPIURL];
    
    AFHTTPRequestOperation *feedAPIURLOperation = [[AFHTTPRequestOperation alloc] initWithRequest:feedAPIURLRequest];
    feedAPIURLOperation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [separateQueue addOperation:feedAPIURLOperation];
    
    [feedAPIURLOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [separateQueue addOperationWithBlock:^{
            NSArray *responseArray = (NSArray *)responseObject;
            completionHandler(YES, responseArray);
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [separateQueue addOperationWithBlock:^{
            NSLog(@"Error doing API Feed request: %@", error.localizedDescription);
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                 message:@"Connection messed up"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancel"
                                                       otherButtonTitles:@"OK", nil];
            [errorAlert show];
            completionHandler(NO, nil);
        }];
    }];
    
}

+(void)getInterestFeedItemForIdNumber:(NSNumber *)uniqueIDNumber WithCompletion:(void (^)(NSArray *items))completionBlock
{
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
    NSString *interestsAPIURL = [NSString stringWithFormat:@"http://makersfinders.firehawkcreative.com/api/v1/categories/%@",uniqueIDNumber];
    
    [backgroundQueue addOperationWithBlock:^{
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:interestsAPIURL
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject)
         {
             NSOperationQueue *newQueue = [[NSOperationQueue alloc] init];
             [newQueue addOperationWithBlock:^{
                 completionBlock(responseObject);
             }];
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
             NSLog(@"Fail: %@",error.localizedDescription);
         }];
    }];
}


@end


