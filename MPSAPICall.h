//
//  MPSAPICall.h
//  MakersFindersUserProfile
//
//  Created by matt on 7/31/14.
//  Copyright (c) 2014 mpsauce. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface MPSAPICall : NSObject

-(void)etsyAPICall:(void (^)())completionHandler;

@end
