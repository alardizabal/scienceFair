//
//  FISDataStore.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISDataStore.h"
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

-(void)placeHolderImages
{
    for (NSInteger i=0; i<30; i++)
    {
        UIImage *placeHolderImage = [UIImage imageNamed:@"placeholder.png"];
        FlickrPhoto *newPhoto = [[FlickrPhoto alloc] init];
        newPhoto.thumbnail = placeHolderImage;
        [self.flickrPhotoFeed addObject:newPhoto];
    }
}

-(void)flickrFeedImages:(void (^)(NSArray *))completionHandler
{
    Flickr *tempFlickrtoProvideFeedImages = [[Flickr alloc] init];
    [tempFlickrtoProvideFeedImages searchFlickrForTerm:@"likedaffodils"
                                       completionBlock:^(NSArray *results, NSError *error) {
                                           completionHandler(results); 
                                       }];
}

@end
