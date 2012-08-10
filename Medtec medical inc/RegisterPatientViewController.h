//
//  RegisterPatientViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedTecNetwork.h"
#import "PatientInfo.h"



@class Medtec_medical_incAppDelegate;
@class AppHeaderView;
@class DemographicsView;
@class AppFooterView;

extern NSMutableDictionary *global_userDetails;

@interface RegisterPatientViewController : UIViewController <UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate , NetworkDelegate , UIAlertViewDelegate>
{
    Medtec_medical_incAppDelegate *appDelegate;
    AppHeaderView     *appHeaderView;
    AppFooterView     *appFooterView;
    DemographicsView  *demoGraphicsView;
    
     
    PatientInfo *patientInfo;
    
    IBOutlet UIScrollView *bgScrollView;
    UIButton *doneButton;
      
    /////////////////////////////    

    IBOutlet UITextField *firstNameTxtField;
    IBOutlet UITextField *middleNameTxtField;
    IBOutlet UITextField *lastNameTxtField;
    IBOutlet UITextField *dobTxtField;
    IBOutlet UITextField *phoneNo1TxtField;
    IBOutlet UITextField *genderTxtField;
    IBOutlet UITextField *ageTxtField;    
    IBOutlet UITextField *emergencyContactTxtField;
    IBOutlet UITextField *emergencyContactPhoneNoTxtField;    
    IBOutlet UITextField *address1TxtField;
    IBOutlet UITextField *address2TxtField;
    IBOutlet UITextField *cityTxtField;
    IBOutlet UITextField *stateTxtField;
    IBOutlet UITextField *zipTxtField;
    IBOutlet UITextField *emailIdTxtField;
    IBOutlet UITextField *patientAccNoTxtField;
    IBOutlet UITextField *hicnTxtField;
    IBOutlet UITextField *insurance1IDTxtField;
    IBOutlet UITextField *practiseIdTxtField;

    UITextField *storeTextField;
    
    UIActivityIndicatorView *activityIndicator;
    BOOL fromEditCall;
   
   
    int selectedProvider;
    
    //animation
    IBOutlet UIToolbar *keyBoardToolBar;
    IBOutlet UIBarButtonItem *prvButton,*nextButton;
    IBOutlet UIDatePicker *datePicker;
    IBOutlet UIView *popView;
    
    UIAlertView *progressAlert;
    
    //gender picker
    IBOutlet UIPickerView *genderPicker;
    NSArray *genderArray;
    
    //provider id 
    IBOutlet UIPickerView *providerIdPicker;
    
    IBOutlet UIButton *drivingLicenseButton;
    UIPopoverController *popover;
    NSString *practiceID;
    NSString *providerID;
    IBOutlet UIButton *insuranceType_Self;
    IBOutlet UIButton *insuranceType_Dependent;
    IBOutlet UIImageView *insuranceBg;
    IBOutlet UILabel *statusLabel;
    IBOutlet UILabel *insuranceIdLabel;
    IBOutlet UITextField *insuranceId;
    IBOutlet UILabel *subscriberNameLabel;
    IBOutlet UITextField *subscriberName;
    IBOutlet UILabel *relationShipLabel;
    IBOutlet UITextField *relationShip;
    BOOL isSelf;
    BOOL isDependent;
    
    
    IBOutlet UIImageView *patientPicture;
    IBOutlet UIView *patientImageView;
    IBOutlet UIImageView *driverLicenseImage;
    IBOutlet UIImageView *insurancecardImage1;
    IBOutlet UIImageView *insurancecardImage2;
    IBOutlet UIPickerView *relationPicker;
    NSMutableArray *relationPickerArray;

}


@property BOOL fromEditCall;
@property (nonatomic,retain) NSMutableDictionary *fromEditDict;
@property (nonatomic,retain)  NSMutableDictionary *registerRequestDict;
@property (nonatomic,retain)PatientInfo *patientInfo;


-(void)signOutButtonClicked;
-(void)signatureButonClicked;
-(void)textFieldsResignMethods;
-(void)callRegisterWebServices;
-(void)cancelConnection:(NSTimer *)myTimer;
-(IBAction)addOrEditDemography;
-(void)setAnimationToScrollView;
-(void)popView:(int)value :(NSString *)name;

//keyboard actions

- (IBAction) nextTextField;
- (IBAction) prevTextField;
-(IBAction)dobSelectedAction:(id)sender;
-(void)keyBoardToolBaranimation:(int)value;
-(void)getProviderIDS;

- (void)pickImageFromPhotoLibrary;
- (void)pickImageFromCamera;

-(IBAction)insuranceTypeForSelf:(id)sender;
-(IBAction)insuranceTypeForDependent:(id)sender;

-(void)testdata;
-(void)updatePatientInfo:(NSMutableDictionary*)bundle;    



@end
