//
//  SearchPatientDetailsViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 10/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppHeaderView;
@class DemographicsView;
@class NewEncountersViewController;
@class MainViewController;
@class RegisterPatientViewController;




@interface SearchPatientDetailsViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

{
    AppHeaderView     *appHeaderView;
    DemographicsView  *demoGraphicsView;
    
    UIImagePickerController *cameraPickerController;
    NSMutableDictionary *imagesDict;
    MainViewController *mainViewController;
    RegisterPatientViewController *registerPatientViewController;

    ///////////// TextFields
    
    IBOutlet UITextField *firstNameTxt;
    IBOutlet UITextField *lastNameTxt;
    IBOutlet UITextField *dobTxt;
    IBOutlet UITextField *insurenceIdTxt;
    IBOutlet UITextField *insurenceNameTxt;
    IBOutlet UITextField *emergencyContactTxt;
    IBOutlet UITextField *phoneTxt;
    IBOutlet UITextField *addressTxt;
    IBOutlet UITextField *stateTxt;
    IBOutlet UITextField *cityTxt;
    IBOutlet UITextField *zipTxt;
    IBOutlet UITextField *sexTxt;
    
    
    IBOutlet UIButton *insurenceCard1;
    IBOutlet UIButton *insurenceCard2;
    int senderTag;
    
    NSMutableDictionary *selecteddictionary;
    
    
    NSMutableURLRequest *searchPatienteditRequest;
    NSURLConnection     *searchPatienteditConnection;
    NSTimer              *edittimer;
    BOOL                 searchPatienteditDataRecived;
    NSMutableData        *searchPatienteditWebServiceData;
    UIActivityIndicatorView *editactivityIndicator;
    NSMutableDictionary *searchPatienteditResponseDict;
    
    
    
    NSMutableURLRequest *searchPatientdeleteRequest;
    NSURLConnection     *searchPatientdeleteConnection;
    NSTimer              *deletetimer;
    BOOL                 searchPatientdeleteDataRecived;
    NSMutableData        *searchPatientdeleteWebServiceData;
    UIActivityIndicatorView *deleteactivityIndicator;
    NSMutableDictionary *searchPatientdeleteResponseDict;  
    
    BOOL fromDeleteMethod;
    
}
-(IBAction)newEncountersButtonClicked:(id)sender;
-(IBAction)copyEncountersButtonClicked:(id)sender;
-(IBAction)showEncountersButtonClicked:(id)sender;
-(IBAction)homeButtonClicked:(id)sender;
-(IBAction)alertsButtonClicked:(id)sender;
-(IBAction)searchButtonClicked:(id)sender;
-(IBAction)newPatientButtonClicked:(id)sender;
-(IBAction)insurenceCard1ButtonClicked:(UIButton *)insurenceCard;
-(IBAction)editButtonClicked:(id)sender;
-(IBAction)deleteButtonClicked:(id)sender;
-(void)signOutButtonClicked;
-(void)textFieldsResignMethod;
-(void)cancelConnection:(NSTimer *)myTimer;
-(IBAction)addToVisit:(id)sender;


@property(nonatomic,retain) NSMutableDictionary *selecteddictionary;

@end
