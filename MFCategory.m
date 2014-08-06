//
//  MFCategory.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFCategory.h"
#import "MFInterest.h"


@implementation MFCategory

@dynamic name;
@dynamic imageURL;
@dynamic interests;

+(instancetype)categoryWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFCategory" inManagedObjectContext:context];
}

@end
