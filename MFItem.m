//
//  MFItem.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/8/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFItem.h"
#import "MFCategory.h"
#import "MFUser.h"


@implementation MFItem

@dynamic uniqueID;
@dynamic imageURL;
@dynamic itemDescription;
@dynamic itemType;
@dynamic loves;
@dynamic name;
@dynamic category;
@dynamic user;


+(instancetype)itemWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFItem" inManagedObjectContext:context];
}

@end
