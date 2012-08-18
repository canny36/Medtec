//
//  BillerInfo.m
//  Medtec medical inc
//
//  Created by Logic2 on 17/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "BillerInfo.h"
#import "Util.h"

@interface BillerInfo()



@property(nonatomic , retain,readwrite)NSString *patientName;

@property(nonatomic , retain,readwrite)NSString *date;
@property(nonatomic , retain,readwrite)NSString *practiceUserTye;

@property(nonatomic , retain,readwrite)NSString *msgDesc;
@property(nonatomic , retain,readwrite)NSString *statusCode;
@property(nonatomic , retain,readwrite)NSString *statusDesc;

-(void)initVars:(NSDictionary*)dict;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;

@end

@implementation BillerInfo

@synthesize patientID,patientName,date , practiceUserTye , messageID,msgDesc,statusCode,statusDesc,practiceID,encounterId;

- (id)initWithDict:(NSDictionary*)bundle {
    self = [super init];
    if (self) {
        [self initVars:bundle];
    }
    return self;
}

-(void)initVars:(NSDictionary*)dict{
    //    
    //    {
    //        "PatientID": 60,
    //        "PracticeID": 1,
    //        "PatientName": "gopi logictrree",
    //        "EncounterID": 10,
    //        "Date": "/Date(1344623400000)/",
    //        "PracticeUserType": "Biller",
    //        "Message_ID": 2,
    //        "Message_Desc": "test Desc1",
    //        "StatusCode": "OPEN",
    //        "StatusDesc": "Open"
    //    },
    
    self.patientID = [[self getValue:@"PatientID" :dict] intValue];
    self.practiceID = [[self getValue:@"PracticeID" :dict] intValue];
    self.patientName = [self getValue:@"PatientName" :dict];
    self.encounterId = [[self getValue:@"EncounterID" :dict] intValue];
    self.date =  [Util convertDateFormat:[self getValue:@"Date" :dict]];
    self.practiceUserTye = [self getValue:@"PracticeUserType" :dict];
    self.messageID = [[self getValue:@"Message_ID" :dict] intValue];
    self.msgDesc = [self getValue:@"Message_Desc" :dict];
    self.statusCode = [self getValue:@"StatusCode" :dict];
    self.statusDesc = [self getValue:@"StatusDesc" :dict];
    
}

-(id)getValue:(NSString*)key:(NSDictionary*)bundle{
    
    id value = [bundle objectForKey:key];
    if (value != nil && value != [NSNull null]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%d",[value intValue]];
        }
        return value;
    }
    return @""; 
}

+(NSMutableArray*)collection:(id)billerJsonArray{
    
    NSMutableArray * collection = [[NSMutableArray alloc]init];
    
    if ([billerJsonArray isKindOfClass:[NSArray class]]) {
        int count  = [billerJsonArray count];
        for (int i=0;i<count; i++) {
            id obj = [billerJsonArray  objectAtIndex:i];
            if ([obj isKindOfClass:[NSDictionary class]]) {
                BillerInfo *bInfo = [[BillerInfo alloc]initWithDict:obj];
                [collection addObject:bInfo];
                [bInfo release];
            }
        }
    }
    return collection;
}


@end
