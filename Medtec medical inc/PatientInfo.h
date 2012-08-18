//
//  PatientInfo.h
//  Medtec medical inc
//
//  Created by Logic2 on 08/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>


//
//Date = "/Date(1342031400000)/";
//"Date_Of_Birth" = "/Date(431548200000)/";
//EncounterID = 7;
//"Encounter_StatusID" = 4;
//"Equip_Name" = "Surgical Lights";
//"Equip_Options" = purchase;
//FirstName = sai;
//FromDate = "/Date(1342031400000)/";
//Insurance1ID = 11;
//LastName = bondugula;
//PatientID = 18;
//"Patient_StatusID" = 1;
//PhoneNumber1 = 9000687123;
//PracticeID = 1;
//ToDate = "/Date(1342031400000)/";

#define KEY_DATE @"";



@interface PatientInfo : NSObject{
    
    NSString *date;
    NSString *dob;
    int encounterID;
    int encounterStatusId;
    
    NSString *equipname;
    NSString *equipOptions;
    NSString *firstname;
    NSString *lastname;
    NSString *fromDate;
    NSString *insuranceId;
    int patientId;
    int patientStatusId;
    int phoneNo;
    int practiceId;
    NSString *toDate;
    NSString *lvDate;
    int encountersCount;
}

@property(nonatomic,retain ,readonly)NSString *date;
@property(nonatomic, retain ,readonly)NSString *dob;
@property(readonly)int encounterID;
@property(readonly)int encounterStatusId;
@property(nonatomic,retain ,readonly)NSString *equipname;
@property(nonatomic,retain ,readonly)NSString *equipOptions;
@property(nonatomic,retain ,readonly)NSString *firstname;
@property(nonatomic,retain ,readonly)NSString *lastname;
@property(nonatomic,retain ,readonly)NSString *fromDate;
@property(nonatomic ,retain,readonly)NSString *insuranceName;
@property(readwrite)int patientId;
@property(readonly)int patientStatusId;
@property(readonly)int phoneNo;
@property(readwrite)int practiceId;
@property(readonly)int encountersCount;
@property(nonatomic,retain ,readonly)NSString *toDate;
@property(nonatomic,retain ,readonly)NSString *lvDate;
- (id)initWithBundle:(NSDictionary*)bundle;
+(PatientInfo*)testPatientInfo;

@end
