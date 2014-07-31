//
//  FISDataStore.m
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import "FISDataStore.h"
#import "FISAPICall.h"
#import "FISPug.h"

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
        _pugImagesArray = [NSMutableArray new];
    }
    return self; 
}

-(void)makePugImagesPugObjects:(void (^)())completionHandler
{
    FISAPICall *tempAPICall = [[FISAPICall alloc] init];
    [tempAPICall retrievePugAPIAndImageFromBackend:^(UIImage *coolPugImage) {
        FISPug *eachPug = [[FISPug alloc] initPugWithImage:coolPugImage];
        [self.pugImagesArray addObject:eachPug];
        completionHandler(); 
    }];
}

@end
