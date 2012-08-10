//
//  Util.h
//  Medtec medical inc
//
//  Created by Logic2 on 08/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject


+(NSString*)convertDateFormat:(NSString*)dateString;
+(UIImage*)imageFromData:(NSString*)binaryString;

@end
