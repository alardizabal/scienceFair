//
//  MFUser.m
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/6/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import "MFUser.h"
#import "MFComment.h"
#import "MFInterest.h"
#import "MFDataStore.h"


@implementation MFUser

@dynamic email;
@dynamic name;
@dynamic token;
@dynamic userID;
@dynamic location;
@dynamic title;
@dynamic profileImageURL;
@dynamic headerImageURL;
@dynamic makes;
@dynamic finds;
@dynamic comments;
@dynamic followers;
@dynamic following;
@dynamic interests;

+(instancetype)userWithContext: (NSManagedObjectContext *)context
{
    return [NSEntityDescription insertNewObjectForEntityForName:@"MFUser" inManagedObjectContext:context];
}

+(MFUser *)currentUser
{
    MFDataStore *store = [MFDataStore sharedStore];
    NSFetchRequest *currentUserFetch = [[NSFetchRequest alloc] initWithEntityName:@"MFUser"];
    NSSortDescriptor *sortByName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    currentUserFetch.sortDescriptors = @[sortByName];
    NSArray *currentUser = [store.context executeFetchRequest:currentUserFetch error:nil];
    return currentUser[0];
}

@end
