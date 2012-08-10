//
//  GetProviderIDs.h
//  Medtec medical inc
//
//  Created by APPLE on 19/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//
#import <Foundation/Foundation.h>

extern NSMutableDictionary *global_userDetails;


@interface GetProviderIDs : NSObject
{
    NSMutableData *providerData;
    
}
+ (GetProviderIDs *)sharedDataSource;
-(void)providerIdsMethod;

@end
