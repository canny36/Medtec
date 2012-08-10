//
//  NewEncountersViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 10/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdCalendarView.h"
#import "PatientInfo.h"

@class AppHeaderView;
@class TdCalendarView;
@protocol CalendarViewDelegate;
@class Medtec_medical_incAppDelegate;

#define PICKER_PROVIDER 1
#define PICKER_JCODE 2
#define PICKER_DIAGNOSIS 3
#define PICKER_DRUG 4


extern NSMutableDictionary *global_userDetails;

@interface NewEncountersViewController : UIViewController<UITextFieldDelegate,CalendarViewDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    AppHeaderView *appHeaderView;
     TdCalendarView  *tdView;
     Medtec_medical_incAppDelegate *appDelegate;
    
    ///////////// TextFields
  /*  IBOutlet UITextField *equipIdTxtField;
    IBOutlet UITextField *dateTxtField;
    IBOutlet UITextField *equipOptionsTxtField;
    IBOutlet UITextField *prescribePhysicianTxtField;
    IBOutlet UITextField *deliveryMethodTxtField;
    IBOutlet UITextField *startRefillDateTxtField;
    IBOutlet UITextField *equipInspectedTxtField;
    IBOutlet UITextField *equipDeliveryTxtField;
    IBOutlet UITextField *facilityNameTxtField;
    IBOutlet UITextField *facilityAddressTxtField;
    IBOutlet UITextField *diagnosisCodeTxtField;
    IBOutlet UITextField *serialNumberTxtField;
    IBOutlet UITextField *typeOfEquipTxtField;
    IBOutlet UITextField *drugTxtField;
    IBOutlet UITextField *hcpcsCodeTxtField;
    IBOutlet UITextField *jCodeTxtField;
    IBOutlet UITextField *equipRcvdTxtField;
    IBOutlet UITextField *beneficiaryNameTxtField;
    IBOutlet UITextField *mcrNotesTxtField;
    IBOutlet UITextField *pdrLegalGuardTxtField;
    IBOutlet UITextField *piiGuardRelationTxtField;
    IBOutlet UITextField *piiGuardFirstNameTxtField;
    IBOutlet UITextField *piiGuardLastNameTxtField;
    IBOutlet UITextField *piiGuardAdd1TxtField;
    IBOutlet UITextField *piiGuardAdd2TxtField;
    IBOutlet UITextField *piiGuardCityTxtField;
    IBOutlet UITextField *piiGuardStateTxtField;
    IBOutlet UITextField *piiGuardZipTxtField;
    IBOutlet UITextField *piiGuardEmailTxtField;
    IBOutlet UITextField *piiGuardPhoneTxtField;
    IBOutlet UITextField *ptnPhysicianNameTxtField;
    IBOutlet UITextField *ptnTimesTxtField;
    IBOutlet UITextField *ptnDaysTxtField;
    IBOutlet UITextField *ptnAdminTxtField;
    IBOutlet UITextField *ptnAdminIfnoTxtField;
    IBOutlet UITextField *ptnInfusionTxtField;
    IBOutlet UITextField *ptnEquipTxtField;
    IBOutlet UITextField *dmeifInitialDateTxtField;
    IBOutlet UITextField *dmeifRevisedDateTxtField;
    IBOutlet UITextField *dmeifRecertificationDateTxtField;
    IBOutlet UITextField *statusTxtField;
    IBOutlet UITextField *estimatedTreatDurationTxtField;*/
    IBOutlet UIScrollView *bgScrollView;
    
     IBOutlet UIView *popupView;
    IBOutlet UIToolbar *dobToolBar;
    UITextField *storeTextField;
    BOOL validationSuccess;
    NSMutableDictionary *createEncounterDict;
    
    ////////// webservices.................    
    NSMutableURLRequest *urlRequest,*equipRequest;
    NSURLConnection *urlConnection,*dataConnection;
    NSTimer *timer;
    NSMutableData *webServiceData,*equipWebServiceData;
    BOOL encounterDataReceived;
    NSString *patientId;
    NSMutableDictionary *equipResponseDict;
    
    IBOutlet UIPickerView *equipPicker;
    IBOutlet UIToolbar *toolBar;
    NSMutableArray *equipPickerArray;
    NSMutableArray *pickerArray;
    int pickerIndex;
    
    PatientInfo *info;
    
    ///Required text fields
    
    IBOutlet UILabel *patientName;
    IBOutlet UILabel *dob;
    IBOutlet UILabel *age;
    IBOutlet UILabel *middleName;
    IBOutlet UILabel *lastName;
    IBOutlet UILabel *insuranceType;
    IBOutlet UILabel *phoneNo;
    IBOutlet UILabel *emergencyPhoneNo;
    IBOutlet UILabel *emergencyContactNo;
    IBOutlet UILabel *insuranceName;
    
    IBOutlet UITextField *providerTxtField;
    IBOutlet UITextField *diagnosisCodeTxtField;    
    IBOutlet UITextField *estimatedTreatDurationTxtField;
    IBOutlet UITextField *typeOfInfusionPumpTxtField;    
    IBOutlet UITextField *drugTxtField;    
    IBOutlet UITextField *startDateTxtField;
    IBOutlet UITextField *pumpSerialTxtField;
    IBOutlet UITextField *hcpcsCodeTxtField;    
    IBOutlet UITextField *jCodeTxtField;    
    
    
    IBOutlet UILabel *contiInfusionTimeLabel;
    IBOutlet UILabel *contiInfusiondaysLabel;
    IBOutlet UIButton *contiAdminYesButton;
    IBOutlet UIButton *contiAdminNoButton;
    IBOutlet UIButton *intravenousInfusionYesButton;   
    IBOutlet UIButton *intravenousInfusionNoButton;  
    IBOutlet UIButton *prescriptionPumpAmbitButton;
    IBOutlet UIButton *prescriptionPumpCADDButton;
    IBOutlet UIButton *prescriptionPumpWalkMedButton;
    IBOutlet UIButton *prescriptionPumpCurlinButton;
    IBOutlet UIButton *prescriptionPumpOtherButton;
    IBOutlet UILabel *ptnDaysTxtField;
    IBOutlet UILabel *ambulatoryPumpManufacturer;
    
    IBOutlet UIButton *beneficiaryButton;
    IBOutlet UIButton *shippingButton;
    IBOutlet UIButton *nursingButton;  
    
    IBOutlet UIButton *rentButton;
    IBOutlet UIButton *buyButton;
    
    IBOutlet UITableView *accessoryTable;
    IBOutlet UITableView *encounterListTable;
    
    NSMutableArray *diagnosisCodeArray;
    NSMutableArray *drugArray;
    NSMutableArray *jCodeArray;     
    
    IBOutlet UIPickerView *picker;

}

@property(nonatomic,retain)NSString *patientId;
@property(nonatomic,retain)NSMutableDictionary *patientDictionary;
@property(nonatomic,retain)PatientInfo *info;

-(void)signOutButtonClicked;
-(void)textFieldsResignMethod;

-(IBAction)toolBar_cancelAction:(id)sender;
-(IBAction)toolBar_saveAction:(id)sender;

-(IBAction)rentalAction:(id)sender;
-(IBAction)buyAction:(id)sender;


-(IBAction)caYesAction:(id)sender;
-(IBAction)caNoAction:(id)sender;
-(IBAction)iiYESAction:(id)sender;
-(IBAction)iiNoAction:(id)sender;

-(IBAction)ambitAction:(id)sender;


-(IBAction)dtodDeliveryAction:(id)sender;
-(IBAction)ssDeliveryAction:(id)sender;
-(IBAction)tnfDeliveryAction:(id)sender;


-(void)popView:(int)value;
-(void)checkValidation;
-(void) createRequestForNewEncounter;
-(void)saveEncounter;
-(void)addDataToDictionary;
-(void)testData;
-(void)getPracticeEquipments;
-(void)viewanimation:(int)value;
-(void)pickerViewanimation:(int)value :(int)toolValue;
-(IBAction)DoneAction:(id)sender;
-(IBAction)newEncounter:(id)sender;
-(IBAction)editEncounter:(id)sender;

@end
