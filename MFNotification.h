//
//  MFNotification.h
//  MakersFinders_Master
//
//  Created by Daniel Sun on 8/8/14.
//  Copyright (c) 2014 ADMM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MFNotification : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSNumber * uniqueID;

@end
