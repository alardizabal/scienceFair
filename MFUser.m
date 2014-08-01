//
//  MFUser.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/1/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFUser.h"


@implementation MFUser

@dynamic email;
@dynamic name;
@dynamic token;
@dynamic userID;

+(instancetype)userWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFUser" inManagedObjectContext:context];
}

@end
