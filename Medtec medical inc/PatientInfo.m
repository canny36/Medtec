//
//  PatientInfo.m
//  Medtec medical inc
//
//  Created by Logic2 on 08/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "PatientInfo.h"
#import "Util.h"

@interface PatientInfo()


@property(nonatomic,retain ,readwrite)NSString *date;
@property(nonatomic,retain ,readwrite)NSString *dob;
@property(readwrite)int encounterID;
@property(readwrite)int encounterStatusId;
@property(nonatomic,retain,readwrite)NSString *equipname;
@property(nonatomic,retain,readwrite)NSString *equipOptions;
@property(nonatomic,retain,readwrite)NSString *firstname;
@property(nonatomic,retain,readwrite)NSString *lastname;
@property(nonatomic,retain,readwrite)NSString *fromDate;
@property(nonatomic,retain,readwrite)NSString *insuranceName;

@property(readwrite)int patientStatusId;
@property(readwrite)int phoneNo;

@property(nonatomic,retain,readwrite)NSString *toDate;
@property(nonatomic,retain,readwrite)NSString *lvDate;
@property(readwrite)int encountersCount;
#pragma mark - method declaration
-(void)initvars:(NSDictionary*)bundle;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;

@end

@implementation PatientInfo

@synthesize dob , firstname,lastname,encounterID,date,toDate,patientStatusId,patientId,insuranceName,fromDate,equipOptions,encounterStatusId,phoneNo,practiceId,equipname , encountersCount ,lvDate;
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

- (id)init {
    self = [super init];
    if (self) {
        [self initWithBundle:nil];
    }
    return self;
}

- (id)initWithBundle:(NSDictionary*)bundle {
    self = [super init];
    if (self) {
        
        if (bundle != nil) {
          [self initvars:bundle];
        }else{
            return nil;
        }
        
    }
    return self;
}

-(void)initvars:(NSDictionary*)bundle{
    
    @try {
        self.date = [Util convertDateFormat:[bundle objectForKey:@"Date"]];
        self.dob  = [Util convertDateFormat:[bundle objectForKey:@"Date_Of_Birth"]];
      
        
        
        id no = [bundle objectForKey:@"EncounterID"];
        if (no != [NSNull null]) {
            self.encounterID = [no intValue];
        }
       
       
        no = [bundle objectForKey:@"EncounterStatusId"];
        if (no != [NSNull null]) {
            self.encounterStatusId = [no intValue];
        }
        
        
        no = [bundle objectForKey:@"Encounters"];
        if (no != [NSNull null]) {
            self.encountersCount = [no intValue];
        }
        
        self.equipname = [bundle objectForKey:@"Equip_Name"];
        self.equipOptions = [bundle objectForKey:@"Equip_Options"];
        self.firstname = [bundle objectForKey:@"FirstName"];
        
        self.fromDate = [Util convertDateFormat:[bundle objectForKey:@"FromDate"]];
        
        no = [bundle objectForKey:@"InsuranceName"];
        self.insuranceName = no;
               
        self.lastname = [bundle objectForKey:@"LastName"];
        
        no = [bundle objectForKey:@"PatientID"];
        if (no != [NSNull null]) {
             self.patientId = [no intValue];
        }
                         
        no = [bundle objectForKey:@"Patient_StatusID"];
        if(no != [NSNull null]){
            self.patientStatusId = [no intValue];
         }
             
        no = [bundle objectForKey:@"PracticeID"];
        if(no != [NSNull null]){
           self.practiceId = [no intValue];       
        }
             
        self.phoneNo = [[self getValue:@"PhoneNumber1" :bundle] intValue];
        
        self.lvDate = [Util convertDateFormat:[bundle objectForKey:@"LastVisit"]];

    }
    @catch (NSException *exception) {
        NSLog(@"Error initialising  vars with exception %@ ",[exception description]);
    }
    @finally {
        
    }
    
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

+(PatientInfo*)testPatientInfo{
    
//    Date = "/Date(1342031400000)/";
//    "Date_Of_Birth" = "/Date(431548200000)/";
//    EncounterID = 7;
//    "Encounter_StatusID" = 4;
//    "Equip_Name" = "Surgical Lights";
//    "Equip_Options" = purchase;
//    FirstName = sai;
//    FromDate = "/Date(1342031400000)/";
//    Insurance1ID = 11;
//    LastName = bondugula;
//    PatientID = 18;
//    "Patient_StatusID" = 1;
//    PhoneNumber1 = 9000687123;
//    PracticeID = 1;
//    ToDate = "/Date(1342031400000)/";
    
    PatientInfo *patientInfo = [[PatientInfo alloc]init];
    
    patientInfo.date=[Util convertDateFormat:@"/Date(1342031400000)/"];
    patientInfo.dob= [Util convertDateFormat:@"/Date(431548200000)/"];
    patientInfo.encounterID=7;
    patientInfo.encounterStatusId=4;
    patientInfo.equipname=@"Surgical Lights";
  
    patientInfo.firstname=@"sai";
    patientInfo.fromDate=[Util convertDateFormat:@"/Date(1342031400000)/"];
    patientInfo.insuranceName=@"11";
    patientInfo.lastname=@"bondugula";
    patientInfo.patientId=18;
    patientInfo.patientStatusId=1;
    patientInfo.phoneNo= [@"9000111111" intValue];
    patientInfo.practiceId=1;
    patientInfo.toDate=[Util convertDateFormat:@"/Date(1342031400000)/"];
    
    return patientInfo;
    
    
}


@end
