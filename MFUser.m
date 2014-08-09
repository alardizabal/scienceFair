//
//  MFUser.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/8/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFUser.h"
#import "MFComment.h"
#import "MFInterest.h"
#import "MFItem.h"
#import "MFUser.h"
#import "MFDataStore.h"


@implementation MFUser

@dynamic email;
@dynamic headerImageURL;
@dynamic location;
@dynamic name;
@dynamic profileImageURL;
@dynamic title;
@dynamic token;
@dynamic uniqueID;
@dynamic comments;
@dynamic followers;
@dynamic following;
@dynamic interests;
@dynamic items;

+(MFUser *)currentUser
{
    MFDataStore *store = [MFDataStore sharedStore];
    NSFetchRequest *currentUserFetch = [[NSFetchRequest alloc] initWithEntityName:@"MFUser"];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    currentUserFetch.sortDescriptors = @[sortByName];
    NSArray *currentUser = [store.context executeFetchRequest:currentUserFetch error:nil];
    return currentUser[0];
}

+(instancetype)userWithContext:(NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFUser" inManagedObjectContext:context];
}


@end
