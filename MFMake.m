//
//  MFMake.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFMake.h"
#import "MFUser.h"


@implementation MFMake

@dynamic dateCreated;
@dynamic imageURL;
@dynamic title;
@dynamic price;
@dynamic makeDescription;
@dynamic user;

+(instancetype)makeWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFMake" inManagedObjectContext:context];
}

@end
