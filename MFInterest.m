//
//  MFInterest.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFInterest.h"


@implementation MFInterest

@dynamic name;
@dynamic imageURL;
@dynamic category;

+(instancetype)interestWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFInterest" inManagedObjectContext:context];
}

@end
