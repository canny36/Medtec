//
//  Medtec_medical_incAppDelegate.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "Medtec_medical_incAppDelegate.h"
#import "LoginViewController.h"
#import "Reachability.h"

@implementation Medtec_medical_incAppDelegate

@synthesize window=_window;
@synthesize mainNavigationController;
@synthesize providersArray;
@synthesize loginInfo;
@synthesize accessoryArray;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    loginViewController = [[LoginViewController alloc] init];
    mainNavigationController = [[UINavigationController alloc] initWithRootViewController:loginViewController];
    [self.window addSubview:mainNavigationController.view];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark NetworkHandler
#pragma mark NetworkHandler
- (BOOL)updateReachabilityStatus:(Reachability *)reachability
{
    
//	if(reachability != internetReach) return NO;
	
	BOOL statusFlag = NO;	
	NetworkStatus networkStatus = [reachability currentReachabilityStatus];
	BOOL connectionRequired = [reachability connectionRequired];
	NSString *status = @"";
	switch (networkStatus) {
		case NotReachable:
			status = @"Internet access not available, please check your internet connection.";
			connectionRequired = NO;			
			UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Connection" message:status delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
			break;
		case ReachableViaWWAN:
			status = @"Reachable WWAN";
			statusFlag = YES;
			break;
		case ReachableViaWiFi:
			status = @"Reachable  WiFi";
			statusFlag = YES;
			break;
		default:
			status = @"";
			break;
	}	
	if(connectionRequired) {
		status = @"Connection Required";
	}
	return statusFlag;
	
}

-(BOOL)isNetWorkAvailable
{
//	Reachability *internetReach = [[Reachability reachabilityForInternetConnection] retain];
//	[internetReach startNotifer];
//	if([self updateReachabilityStatus:internetReach])
//	{	
//		return YES;
//	}	
	return YES;
}

/////////////// Internet connection
//-(NetworkStatus)internetStatus
//{
//	reachability=[Reachability sharedReachability];
//	NetworkStatus internetStatus=[reachability internetConnectionStatus];
//	if(internetStatus==NotReachable)
//	{
//		
//	}
//	else {
//		
//		isNetworkIsAvailable=YES;
//	}
//    
//	return internetStatus;
//}
//
//-(NetworkStatus)localWifi
//{
//	reachability=[Reachability sharedReachability];
//	NetworkStatus wifiStatus=[reachability localWiFiConnectionStatus];
//	
//	if(wifiStatus==NotReachable)
//	{
//		
//	}
//	else {
//		isNetworkIsAvailable =YES;
//	}
//    
//	return wifiStatus;
//}

- (void)dealloc
{
    [_window release];
    [providersArray release];
    [accessoryArray release];
    
    [super dealloc];
}

@end
