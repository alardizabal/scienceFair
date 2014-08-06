//
//  MFCategory.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFCategory.h"
#import "MFInterest.h"


@implementation MFCategory

@dynamic imageURL;
@dynamic name;
@dynamic interests;

+(instancetype)categoryWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFCategory" inManagedObjectContext:context];
}

@end
