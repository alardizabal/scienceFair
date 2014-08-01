//
//  FlickrPhoto.m
//  Flickr Search
//
//  Created by Brandon Trebitowski on 6/28/12.
//  Copyright (c) 2012 Brandon Trebitowski. All rights reserved.
//

#import "FlickrPhoto.h"

@implementation FlickrPhoto

-(instancetype)init
{
    return [self initWithFlikrImage:[UIImage new]];
}

-(instancetype)initWithFlikrImage:(UIImage *)flickrArtist
{
    self = [super init];
    if (self) {
        _thumbnail = flickrArtist;
    }
    return self;
}

@end
