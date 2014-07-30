//
//  FISAPICall.h
//  MatchAndConnectApp
//
//  Created by Marcus Smith on 7/28/14.
//  Copyright (c) 2014 Marcus Smith. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISAPICall : NSObject

-(void)retrievePugAPIAndImageFromBackend:(void(^)(UIImage *coolPugImage))completionHandler;

@end
