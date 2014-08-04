//
//  FISDataStore.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *flickrPhotoFeed;

-(instancetype)init; 
+(instancetype)sharedDataStore;
-(void)placeHolderImages;
-(void)flickrFeedImages:(void (^)(NSArray *flickrPhotosArray))completionHandler;

@end
