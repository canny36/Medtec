//
//  Util.m
//  Medtec medical inc
//
//  Created by Logic2 on 08/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Util.h"

@implementation Util

+(NSString*)convertDateFormat:(NSString*)dateString{
    
    
    if (dateString == nil || [dateString isKindOfClass:[NSNull class]]) {
        return @"";
    }
    
     NSRange dateTag = [dateString rangeOfString:@"("];
    if (dateTag.location != NSNotFound) 	
    {
        int startPos = [dateString rangeOfString:@"("].location+1;
        int endPos = [dateString rangeOfString:@")"].location;
        if (startPos >0 && endPos >0 )
        {
            NSRange range = NSMakeRange(startPos,endPos-startPos);            
            unsigned long long milliseconds = [[dateString substringWithRange:range] longLongValue];
            //NSLog(@"%llu",milliseconds);
            NSTimeInterval interval = milliseconds/1000;
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
            
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
            [dateFormatter setDateFormat:@"MM/dd/YYYY"];
            NSString *dateString = [dateFormatter stringFromDate:date];
            [dateFormatter release]; 
            
            NSLog(@"\n Date from Util after conversion is %@",dateString);
            
            return dateString;
        }
        
    }
    return nil;

}

+(UIImage*)imageFromData:(NSString*)binaryString{
    
    NSData* data = [binaryString dataUsingEncoding:NSUTF8StringEncoding];
    return [UIImage imageWithData:data];
    
}

@end
