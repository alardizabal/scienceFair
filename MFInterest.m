//
//  MFInterest.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFInterest.h"
#import "MFCategory.h"
#import "MFUser.h"


@implementation MFInterest

@dynamic imageURL;
@dynamic name;
@dynamic category;
@dynamic users;

+(instancetype)interestWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFInterest" inManagedObjectContext:context];
}

@end
