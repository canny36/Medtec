//
//  LoginViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Medtec_medical_incAppDelegate;
@class MainViewController;
#import "MedTecNetwork.h"


@interface LoginViewController : UIViewController <UITextFieldDelegate,NetworkDelegate>

{
    MainViewController *mainViewController;
    Medtec_medical_incAppDelegate *appDelegate;
    
    UIAlertView *progressAlert;
    
    IBOutlet UIScrollView *scrollView;
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *passwordTextField;
    IBOutlet UITextField *practiseOrLocationTextField,*buffertxtField;;
    IBOutlet UIButton    *loginButton;
    IBOutlet UIButton    *forgotPasswordButton;   
    
    NSString *userName;
    NSString *password;
    NSString *practiseOrLocation;
    NSMutableDictionary *loginResponseDict;
    
    
    /////////////Web services Information
    NSURLRequest *loginRequest;
    NSMutableURLRequest *loginUrlRequest;              
    NSURLConnection *loginConnection,*dataConnection;
    NSMutableData *loginWebServiceData,*practiceData;
    NSTimer *timer;
    BOOL loginDataReceived;
    UIActivityIndicatorView *activityIndicator;
    
    
    NSMutableDictionary *loginDetailsDict; 
    BOOL validationSuccess;
    NSMutableArray *praciceNameArray;
    IBOutlet UIPickerView *practicePicker;
    IBOutlet UIToolbar *toolBar;
    int pickerIndex;
    
      
}
-(IBAction)loginButtonClicked:(id)sender;
-(IBAction)forgotPasswordButtonClicked:(id)sender;
-(void)callAuthenticationWebServices;
-(void)cancelConnection:(NSTimer *)myTimer;
-(void)loginWebServiceResponseMethod;
-(void)validDeatils;
-(void)viewanimation:(int)value ;
//tool bar 
-(IBAction)DoneAction:(id)sender;
-(void)pickerViewanimation:(int)value :(int)toolValue;

@end
