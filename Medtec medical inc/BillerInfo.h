//
//  BillerInfo.h
//  Medtec medical inc
//
//  Created by Logic2 on 17/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BillerInfo : NSObject{
    
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
    
    
  
    int patientID;
    int practiceID;
    NSString *patientName;
    int encounterId;
    NSString *date;
    NSString *practiceUserTye;
    int messageID;
    NSString *msgDesc;
    NSString *statusCode;
    NSString *statusDesc;

}
@property int patientID;
@property int practiceID;
@property(nonatomic , retain,readonly)NSString *patientName;
@property int encounterId;
@property(nonatomic , retain,readonly)NSString *date;
@property(nonatomic , retain,readonly)NSString *practiceUserTye;
@property int messageID;
@property(nonatomic , retain,readonly)NSString *msgDesc;
@property(nonatomic , retain,readonly)NSString *statusCode;
@property(nonatomic , retain,readonly)NSString *statusDesc;

+(NSMutableArray*)collection:(id)billerJsonArray;
- (id)initWithDict:(NSDictionary*)bundle;
@end
