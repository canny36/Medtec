//
//  SearchPatientViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdCalendarView.h"
#import "MedTecNetwork.h"
#import "PatientInfo.h"
#import "PopoverController.h"


@class AppHeaderView;
@class TdCalendarView;
@protocol CalendarViewDelegate;
@class Medtec_medical_incAppDelegate;
@class MainViewController;



@interface SearchPatientViewController : UIViewController <UITableViewDataSource,
UITableViewDelegate,UITextFieldDelegate,CalendarViewDelegate,NetworkDelegate,UIPopoverControllerDelegate,PopupDelegate>

{ 
    Medtec_medical_incAppDelegate *appDelegate;
    AppHeaderView *appHeaderView;
    TdCalendarView  *tdView;
    MainViewController *mainViewController;
    
    IBOutlet UIImageView *searchTableBgImage;
    
    UITableView   *searchPatientTableView;
    
    UIPopoverController *popOverController;
  
    ///////////// TextFields
    
    IBOutlet UITextField *selectProviderTxt;
    IBOutlet UITextField *firstNameTxt;
    IBOutlet UITextField *lastNameTxt;
    IBOutlet UITextField *dobTxt;
    IBOutlet UITextField *equipmentNameTxt;
    IBOutlet UITextField *insurenceIdTxt;
    IBOutlet UITextField *date1Txt;
    IBOutlet UITextField *date2Txt;
    IBOutlet UITextField *phoneTxt;
  
    UITextField *storeTextField,*previousTxtField;
    BOOL firstDateFieldTxt;
    
    NSMutableArray *tmpArray;
    NSMutableArray *keysArray;
    NSMutableArray *patientInfoArray;
    UIAlertView *progressAlert;

    ////////// webservices.................    
    NSMutableURLRequest *searchRequest;
    NSURLConnection     *searchConnection;
    NSTimer              *timer;
    BOOL                 searchDataRecived;
    NSMutableData        *searchWebServiceData;
    UIActivityIndicatorView *activityIndicator;
    NSMutableDictionary *searchResponseDict;  
    BOOL isRentSelected,isBuySelected;
    IBOutlet UIButton *rentButton,*buyButton;
    
    //dob picked
    IBOutlet UIDatePicker *dobPicker;
    IBOutlet UIToolbar *dobToolBar;
    IBOutlet UIView *popupView;
    NSString *equTypeString;
    IBOutlet UIPickerView *providersPicker;
    int providerPickerIndex;
    int curOption;
    NSString *practiceID;
    IBOutlet UILabel *currentDate;
    IBOutlet UILabel *currentTime;
    
    IBOutlet UIButton *providerButton;
    
}

-(IBAction)calenderButtonClicked:(UIButton *)sender;
-(IBAction)newPatientButtonClicked:(UIButton *)sender;
-(IBAction)alertsButtonClicked:(UIButton *)sender;
-(IBAction)homeButtonClicked:(UIButton *)sender;
-(void)signOutButtonClicked;

-(IBAction)searchButton:(id)sender;
-(void)cancelConnection:(NSTimer *)myTimer;

-(IBAction)toolBar_cancelAction:(id)sender;
-(IBAction)toolBar_saveAction:(id)sender;
-(void)popView:(int)value;
-(IBAction)equType_action:(id)sender;
- (NSDate*) getDateFromJSON:(NSString *)dateString;

-(void)newEncounter:(id)sender:(PatientInfo*)info;
-(void)demography:(id)sender:(PatientInfo*)patient;

-(void)showIndicator;
-(void)dismissIndicator;
-(IBAction)searchPatients;
-(IBAction)clearFileds:(id)sender;

@end
