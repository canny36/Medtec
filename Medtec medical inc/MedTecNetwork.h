//
//  MedTecNetwork.h
//  Medtec medical inc
//
//  Created by Logic2 on 07/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol NetworkDelegate<NSObject>

@required
-(void)onSuccess:(id)result:(int)call;
-(void)onError:(NSString*)errorMsg :(int)call;
-(void)onConnectionTimeOut;

@end


#define CALL_REGISTER 1
#define CALL_GETPATIENT 2
#define CALL_EDITPATIENT 3
#define CALL_SEARCH 4
#define CALL_LOGIN 5
#define CALL_ALLENCOUNTERS 6
#define CALL_SINGLEENCOUNTER 7

#define HOST_PRODUCTION @"http://www.medtecp3.com/"
#define HOST_LOCAL @"http://192.168.1.100/TestingApps/"
#define URL_REGISTER @"http://www.medtecp3.com/MedtecMobilesServices/CreateNewPatient"
#define URL_SEARCH_PATIENT @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetSearchPatients"
#define URL_ALLPATIENTS @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetAllPatientInfo"
#define URL_EDIT_PATIENT @"http://www.medtecp3.com/MedtecMobilesServices/EditPatientInfo"

#define URL_GETPRACTICES @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetAllPractices"
#define URL_CHECKUESERLOGIN @"http://192.168.1.100/TestingApps/MedtecMobilesServices/CheckUserlogins"
#define URL_GETPROVIDERS @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetPracticeProviders"
#define URL_GETPATIENTINFO @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetPatientInfo"

#define URL_GETALLENCOUNTERS @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetAllPatientEncounters"

#define URL_GETSINGLEENCOUNTER @"http://192.168.1.100/TestingApps/MedtecMobilesServices/GetPatientSingleEncounter"

//#define APPEND(STR1 , STR2 )  #STR1 ## #STR2


@interface MedTecNetwork : NSObject
{
    
    int curCall;
    id<NetworkDelegate> delegate;
    NSURLConnection *registerConnection;
    NSMutableData *responseData;
}


+(MedTecNetwork*)shareInstance;
-(void)searchPatients:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate;
-(void)registerPatients:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate;
-(void)getPatientInfo:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate;
-(void)getPatientAllEncounters:(NSMutableDictionary*)bundle:(id<NetworkDelegate>)_delegate;
-(void)getSinglePatientEncounter:(NSMutableDictionary*)bundle:(id<NetworkDelegate>)_delegate;
-(void)login:(NSMutableDictionary*)bundle :(id<NetworkDelegate>)_delegate;
@end