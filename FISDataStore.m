//
//  FISDataStore.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISDataStore.h"
#import "FISAPICall.h"
//Delete after feed data is provided
#import "Flickr.h"
#import "FlickrPhoto.h"

@implementation FISDataStore

+ (instancetype)sharedDataStore {
    static FISDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[FISDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

-(instancetype)init
{
    self = [super self];
    
    if (self) {
        _flickrPhotoFeed = [NSMutableArray new];
    }
    return self; 
}

-(void)flickrFeedImages:(void (^)())completionHandler
{
    Flickr *tempFlickrtoProvideFeedImages = [[Flickr alloc] init];
    NSInteger random = arc4random_uniform(5);
    NSArray *artistsToDisplayFeedImages = @[@"96dpi", @"jeroenbennink", @"spettacolopuro", @"artinteschner", @"shironekoeuro", @"pedrosz"];
    [tempFlickrtoProvideFeedImages searchFlickrForTerm:artistsToDisplayFeedImages[random]
                                       completionBlock:^(NSArray *results, NSError *error) {
                                           for (NSInteger i=0; i<[results count]; i++) {
                                               FlickrPhoto *photoToPass = results[i]; 
                                               [self.flickrPhotoFeed addObject:photoToPass];
                                           }
                                           completionHandler();
                                       }];
}

@end
