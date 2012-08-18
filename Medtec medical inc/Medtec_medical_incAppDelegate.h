//
//  Medtec_medical_incAppDelegate.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Reachability.h"
#import "LoginInfo.h"


@class LoginViewController;


@interface Medtec_medical_incAppDelegate : NSObject <UIApplicationDelegate>
{
    Reachability *reachability;
    UINavigationController *mainNavigationController;
    LoginViewController *loginViewController;
   
    NSMutableArray *providersArray;
    LoginInfo *loginInfo;
    NSMutableArray *accessoryArray;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic,assign)UINavigationController *mainNavigationController;
@property(nonatomic,retain)NSMutableArray *providersArray;
@property(nonatomic,retain)LoginInfo *loginInfo;
@property(nonatomic,retain)NSMutableArray *accessoryArray;

-(BOOL)isNetWorkAvailable;
-(BOOL)updateReachabilityStatus:(Reachability *)reachability;

@end
