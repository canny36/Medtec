//
//  MainViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TdCalendarView.h"
#import "MedTecNetwork.h"
@class Medtec_medical_incAppDelegate;
@class RegisterPatientViewController;
@class AppHeaderView;
@class ManageSettingsViewController;
@class SearchPatientViewController;
@class CaptureSignatureViewController;
@class SearchEquipmentViewController;



@protocol CalendarViewDelegate;
@interface MainViewController : UIViewController <UITextFieldDelegate,CalendarViewDelegate,NetworkDelegate>

{
    
    Medtec_medical_incAppDelegate  *appDelegate;
    RegisterPatientViewController  *registerPatientViewController;
    ManageSettingsViewController   *manageSettingsViewController;
    SearchPatientViewController    *searchPatientViewController;
    CaptureSignatureViewController *captureSignatureViewController;
    SearchEquipmentViewController  *searchEquipmentViewController;
    AppHeaderView     *appHeaderView;
    TdCalendarView    *tdCalenderView;
    
    NSMutableArray *billerInfoArray;
    
    UIImageView *tableBackgroundView;
    NSMutableArray *titlesArray;
    UIButton *disclosureButton;
    UIButton *enLargeButton;
    NSArray *tableImagesArray;
    BOOL originalTableHeight;
    UIButton *animationButton;
    BOOL isInEnlargeMode;
    

    NSString *passwordString;
    IBOutlet UITableView *visitsTable;
    IBOutlet UITableView *messageTable;
    IBOutlet UILabel *currentDate;
   
    /////////////Web services Information
    NSMutableURLRequest *urlRequest;
    NSURLConnection *urlConnection;
    NSTimer *timer;
    NSMutableData *webServiceData;
    BOOL dataReceived;
    NSMutableArray *encountersArray;
    int curOption;
    
   
    
}

@property(nonatomic,assign)BOOL originalTableHeight;

+(MainViewController *)mainViewControllerSharedData;
-(void)setSharedMainViewData :(MainViewController *)mainViewController;
-(IBAction)searchPatientButtonClicked:(id)sender;
-(IBAction)newPatientButtonClicked:(id)sender;
-(IBAction)calenderViewButtonClicked:(id)sender;
-(void)signOutButtonClicked;
-(void)getCurrentEncounters;

-(void)newEncounter:(id)sender;
-(void)newEncounterFromMessage:(id)sender;
-(void)demography:(id)sender;
@end
