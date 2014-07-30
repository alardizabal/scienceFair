//
//  FISAPICall.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISAPICall.h"
#import "FISConstants.h"

@implementation FISAPICall

-(void)retrievePugAPIAndImageFromBackend:(void(^)(UIImage *coolPugImage))completionHandler
{
    NSOperationQueue *pugAPIQueue = [[NSOperationQueue alloc] init];
    pugAPIQueue.maxConcurrentOperationCount = 15;
    NSOperationQueue *pugImageDownloadQueue = [NSOperationQueue new];
    pugImageDownloadQueue.maxConcurrentOperationCount = 15;
    
    for (NSInteger i=0; i<10; i++) {
        NSString *pugAPIURLString = [NSString stringWithFormat:@"%@", PUG_URL];
        
        NSURL *pugAPIURL = [NSURL URLWithString:pugAPIURLString];
        
        NSURLRequest *pugAPIURLRequest = [[NSURLRequest alloc] initWithURL:pugAPIURL];
        
        AFHTTPRequestOperation *pugAPIRequestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:pugAPIURLRequest];
        pugAPIRequestOperation.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [pugAPIQueue addOperation:pugAPIRequestOperation];
        
        [pugAPIRequestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                NSDictionary *responseDictionary = responseObject;
                
                NSString *pugDownloadURLString = [NSString stringWithFormat:@"%@", responseDictionary[@"pug"]];
                
                NSURL *pugImageDownloadURL = [NSURL URLWithString:pugDownloadURLString];
                NSURLRequest *pugImageDownloadRequest = [[NSURLRequest alloc] initWithURL:pugImageDownloadURL];
                
                AFHTTPRequestOperation *pugDownloadImageOperation = [[AFHTTPRequestOperation alloc] initWithRequest:pugImageDownloadRequest];
                pugDownloadImageOperation.responseSerializer = [AFImageResponseSerializer serializer];
                
                [pugImageDownloadQueue addOperation:pugDownloadImageOperation];
                
                [pugDownloadImageOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                    UIImage *pugImageDownload = (UIImage*)responseObject;
                    completionHandler(pugImageDownload);
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"Error in data store: %@", error.localizedDescription);
                    completionHandler(nil);
                }];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error.localizedDescription);
        }];
    }
    
}

@end
