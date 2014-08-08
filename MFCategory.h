//
//  MFCategory.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/8/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MFInterest, MFItem;

@interface MFCategory : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *interests;
@property (nonatomic, retain) NSSet *items;
@end

@interface MFCategory (CoreDataGeneratedAccessors)

+(instancetype)categoryWithContext: (NSManagedObjectContext *)context;

- (void)addInterestsObject:(MFInterest *)value;
- (void)removeInterestsObject:(MFInterest *)value;
- (void)addInterests:(NSSet *)values;
- (void)removeInterests:(NSSet *)values;

- (void)addItemsObject:(MFItem *)value;
- (void)removeItemsObject:(MFItem *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
