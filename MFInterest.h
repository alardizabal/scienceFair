//
//  MFInterest.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/5/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MFInterest : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSManagedObject *category;

+(instancetype)interestWithContext: (NSManagedObjectContext *)context;

@end
