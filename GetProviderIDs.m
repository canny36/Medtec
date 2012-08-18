//
//  GetProviderIDs.m
//  Medtec medical inc
//
//  Created by APPLE on 19/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "GetProviderIDs.h"
#import "JSON.h"
#import "Provider.h"
#import "Medtec_medical_incAppDelegate.h"
#import "MedTecNetwork.h"

@implementation GetProviderIDs

static GetProviderIDs *sharedDataSource = nil;
+ (GetProviderIDs *)sharedDataSource {
	//static DataSource *sharedDataSource = nil;
	//@synchronized( sharedDataSource ) {
	if (sharedDataSource == nil) {
		sharedDataSource = [[GetProviderIDs alloc] init];
	}
	//}
	return sharedDataSource;
}

- (id)init 
{
    
    return self;
    
}


-(void)providerIdsMethod
{
    NSLog(@"GETPROVIDERS = %@ ",URL_GETPROVIDERS);
    NSURL *url = [NSURL URLWithString:URL_GETPROVIDERS];
    NSMutableURLRequest *loginUrlRequest = [NSMutableURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
  Medtec_medical_incAppDelegate *appdelegate=  ( Medtec_medical_incAppDelegate*)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSNumber numberWithInt:appdelegate.loginInfo.practiceID ] forKey:@"PracticeID"];
    id jsonRequest = [dic JSONRepresentation];
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [loginUrlRequest setHTTPMethod:@"POST"];
    [loginUrlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [loginUrlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [loginUrlRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    
    [loginUrlRequest setHTTPBody: requestData];
    
    
    // loginConnection = [[NSURLConnection alloc]initWithRequest:loginUrlRequest delegate:self];
   NSURLConnection *dataConnection = [[NSURLConnection alloc]initWithRequest:loginUrlRequest delegate:self];
    
}

-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data // DATA DIVIDED IN TO PARTS...
{
    
        [providerData appendData:data];
    
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response //WE GET THE RESPONSE HERE...
{
    
        if (providerData != nil) 
        {
            [providerData release];
            providerData = nil;
        }
        providerData = [[NSMutableData alloc]init];
    
    
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection // conn loading is finished here...
{
    
    
    NSString *strResponse = [[NSString alloc]initWithData:providerData encoding:NSUTF8StringEncoding];
    
    SBJSON *json = [[SBJSON new] autorelease]; 
    id result = [json objectWithString:strResponse error:nil];
    
          
     NSMutableArray *providersArray = [[NSMutableArray alloc]init];
    
    
    if ([result isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *json = result;
        Provider *provider = [[Provider alloc]init];
        
        provider.email = [json objectForKey:@"Email"];
        provider.firstName = [json objectForKey:@"FirstName"];
        provider.fullName=[json objectForKey:@"FullName"];
        provider.lastName = [json objectForKey:@"LastName"];
        provider.middleName = [json objectForKey:@"MiddleName"];
        
        provider.npi = [[json objectForKey:@"NPI"] intValue];
        provider.password = [[json objectForKey:@"Password"] intValue];
        provider.phoneNo =  [[json objectForKey:@"PhoneNumber"] intValue];
        provider.practiceId = [[json objectForKey:@"PracticeID"] intValue];
        provider.practiceUserType = [json objectForKey:@"PracticeUserType"];
        provider.statusId = [[json objectForKey:@"StatusID"] intValue];
        provider.userId = [[json objectForKey:@"UserID"] intValue];
        provider.userName = [json objectForKey:@"UserName"];
        
        [providersArray addObject:provider];
        [provider release];
        [providersArray addObject:provider];
        
        
        Medtec_medical_incAppDelegate *appDelegate = (Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication] delegate];
        appDelegate.providersArray = providersArray;
        
        NSLog(@"\nprovidersID_array count : %d",[providersArray count]);
        return;
    }
    
    
    
//        else  if ([result isKindOfClass:[NSArray class]]) 
//            [providersArray addObjectsFromArray:result];
    
       NSLog(@"\nprovidersID_array  : %@",result);
    
 
    
    for (NSDictionary *json in result) {
        Provider *provider = [[Provider alloc]init];
      
            provider.email = [json objectForKey:@"Email"];
            provider.firstName = [json objectForKey:@"FirstName"];
            provider.fullName=[json objectForKey:@"FullName"];
            provider.lastName = [json objectForKey:@"LastName"];
            provider.middleName = [json objectForKey:@"MiddleName"];
    
         provider.npi = [[json objectForKey:@"NPI"] intValue];
         provider.password = [[json objectForKey:@"Password"] intValue];
         provider.phoneNo =  [[json objectForKey:@"PhoneNumber"] intValue];
         provider.practiceId = [[json objectForKey:@"PracticeID"] intValue];
         provider.practiceUserType = [json objectForKey:@"PracticeUserType"];
         provider.statusId = [[json objectForKey:@"StatusID"] intValue];
         provider.userId = [[json objectForKey:@"UserID"] intValue];
         provider.userName = [json objectForKey:@"UserName"];
        
        [providersArray addObject:provider];
        [provider release];
        
       
    }
    
    
       Medtec_medical_incAppDelegate *appDelegate = (Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.providersArray = providersArray;
        
         NSLog(@"\nprovidersID_array count : %d",[providersArray count]);
        
        
    
}



@end
