//
//  MFItem.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/7/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFCategory, MFUser;

@interface MFItem : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * itemDescription;
@property (nonatomic, retain) NSString * itemType;
@property (nonatomic, retain) NSNumber * loves;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) MFCategory *category;
@property (nonatomic, retain) MFUser *user;

+(instancetype)itemWithContext: (NSManagedObjectContext *)context;

@end
