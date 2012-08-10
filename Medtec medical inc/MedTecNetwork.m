//
//  MedTecNetwork.m
//  Medtec medical inc
//
//  Created by Logic2 on 07/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "MedTecNetwork.h"
#import "SBJSON.h"



@interface  MedTecNetwork() 

-(id)init;
-(void)getdataFromServerWithURl:(NSURL*)url : (NSMutableDictionary*)bundle;

@end

static MedTecNetwork *instance;

@implementation MedTecNetwork

+(MedTecNetwork*)shareInstance{
    instance = [[MedTecNetwork alloc]init];
   
    return instance;
}


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}



-(void)getdataFromServerWithURl:(NSURL*)url : (NSMutableDictionary*)bundle{
    
    id jsonRequest = [bundle JSONRepresentation];
    
    NSLog(@"REQUEST BUFFER  = %@ ",jsonRequest);
    
   NSMutableURLRequest *registerRequest = [NSMutableURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];        
    NSData *requestData=[NSData dataWithBytes:[jsonRequest UTF8String]length:[jsonRequest length]];
    
    [registerRequest setHTTPMethod:@"POST"];
    [registerRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [registerRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [registerRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];        
    [registerRequest setHTTPBody:requestData];
        
    if (registerConnection != nil)
    {
        [registerConnection release];
    }
    
   registerConnection = [[NSURLConnection alloc]initWithRequest:registerRequest delegate:self];
    if (responseData != nil ) {
        [responseData release];
        responseData = nil;
    }
}

-(void)getPatientInfo:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate{
    
    NSLog(@" get patient info %@ ", URL_GETPATIENTINFO);
    
    curCall = CALL_GETPATIENT;
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_GETPATIENTINFO] :bundle];
}


-(void)editPatientInfo:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate{
    curCall = CALL_EDITPATIENT;
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_EDIT_PATIENT] :bundle];

}

-(void)searchPatients:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate{
    curCall = CALL_SEARCH;
    NSLog(@" Searchpatients url =  %@",URL_ALLPATIENTS);
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_ALLPATIENTS] :bundle];
}

-(void)registerPatients:(NSMutableDictionary*)bundle : (id<NetworkDelegate>)_delegate{
    curCall = CALL_REGISTER;
     delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_REGISTER] :bundle];

}


-(void)login:(NSMutableDictionary*)bundle :(id<NetworkDelegate>)_delegate
{
    curCall = CALL_LOGIN;
    
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_CHECKUESERLOGIN] :bundle];
}


-(void)getPatientAllEncounters:(NSMutableDictionary*)bundle:(id<NetworkDelegate>)_delegate{
    
      NSLog(@" Allencounters  =  %@",URL_GETALLENCOUNTERS);
    curCall = CALL_ALLENCOUNTERS;
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_GETALLENCOUNTERS] :bundle];
}


-(void)getSinglePatientEncounter:(NSMutableDictionary*)bundle:(id<NetworkDelegate>)_delegate{
    
    NSLog(@" Allencounters  =  %@",URL_GETSINGLEENCOUNTER);
    curCall = CALL_SINGLEENCOUNTER;
    delegate = _delegate;
    [self getdataFromServerWithURl:[NSURL URLWithString:URL_GETSINGLEENCOUNTER] :bundle];
}




#pragma mark - URL Connection delegate methods

-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    if (responseData == nil) {
        responseData = [[NSMutableData alloc]init];
    }
    
    [responseData appendData:data];
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    @try {
        NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;

        NSLog(@" Response code %d ",httpresponse.statusCode );
    }
    @catch (NSException *exception) {
         NSLog(@" Exception = %@ ",exception.description);
    }
    @finally {
        
    }
 
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
    [connection cancel];
    [connection release];
    
    if (responseData != nil) {
        [responseData release];
        responseData = nil;
    }
    
    if (delegate != nil) {
        [delegate onError : [error description]:curCall];
    }
    
    delegate = nil;
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    if (responseData != nil) {
        NSString *strResponse = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"\n REsponse string %@",strResponse);
        
        SBJSON *json = [[SBJSON new] autorelease]; 
        id result = [json objectWithString:strResponse error:nil];
        
        [delegate onSuccess:result:curCall];
                
    }else{
        
        [delegate onError:@"Failed to get data":curCall];
        NSLog(@"failed to get dta");
    }
    
    delegate = nil;
        

}

@end
