//
//  AALAPIClient.m
//  MakersFinders_Master
//
//  Created by Albert Lardizabal on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "AALAPIClient.h"
#import <AFNetworking.h>

@implementation AALAPIClient

+ (void) getCategoryImagesWithCompletion:(void (^)(NSDictionary *dictionary))completionBlock {
    
    
    
//    AFHTTPRequestSerializer *serializer = [[AFHTTPRequestSerializer alloc] init];
//    [serializer setAuthorizationHeaderFieldWithUsername:kGITHUB_API_TOKEN password:@""];
//    manager.requestSerializer = serializer;
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc] init];
        NSString *getCategoryImagesURL = [NSString stringWithFormat:@"http://makersfinders.firehawkcreative.com/api/v1/sectors"];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:getCategoryImagesURL
          parameters:nil
             success:^(NSURLSessionDataTask *task, id responseObject)
         {
//             NSLog(@"%@", responseObject);
//             NSLog(@"Albert %@", responseObject[1][@"name"]);
             [backgroundQueue addOperationWithBlock:^{
                 completionBlock(responseObject);
             }];
             
             
         } failure:^(NSURLSessionDataTask *task, NSError *error)
         {
//             NSLog(@"Fail: %@",error.localizedDescription);
    }];
    
}

@end
