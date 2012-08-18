//
//  EditEncountersViewController.h
//  Medtec medical inc
//
//  Created by Deepika on 28/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Medtec_medical_incAppDelegate.h"
#import "MedTecNetwork.h"
@class AppHeaderView;
@interface EditEncountersViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,NetworkDelegate>
{
    IBOutlet UIScrollView *scrollView;
    AppHeaderView *appHeaderView;
    IBOutlet UITableView *accessoryTable;
    IBOutlet UITableView *encounterListTable;
    
    IBOutlet UILabel *providerTxtField;
    IBOutlet UILabel *diagnosisCodeTxtField;    
    IBOutlet UILabel *estimatedTreatDurationTxtField;
    IBOutlet UILabel *typeOfInfusionPumpTxtField;    
    IBOutlet UILabel *drugTxtField;    
    IBOutlet UITextField *refillDateTxtField;
    IBOutlet UILabel *pumpSerialTxtField;
    IBOutlet UILabel *hcpcsCodeTxtField;    
    IBOutlet UILabel *jCodeTxtField; 
    
    IBOutlet UIButton *contiAdminYesButton;
    IBOutlet UIButton *contiAdminNoButton;
    IBOutlet UIButton *intravenousInfusionYesButton;   
    IBOutlet UIButton *intravenousInfusionNoButton;  
    IBOutlet UIButton *prescriptionPumpAmbitButton;
    IBOutlet UIButton *prescriptionPumpCADDButton;
    IBOutlet UIButton *prescriptionPumpWalkMedButton;
    IBOutlet UIButton *prescriptionPumpCurlinButton;
    IBOutlet UIButton *prescriptionPumpOtherButton;

        
    IBOutlet UIButton *beneficiaryButton;
    IBOutlet UIButton *shippingButton;
    IBOutlet UIButton *nursingButton;  
    
    IBOutlet UIButton *rentButton;
    IBOutlet UIButton *buyButton;
    
    
    int encounterID;
    int patientID;
    
    Medtec_medical_incAppDelegate *appdelegate;
   
}

@property int encounterID;
@property int patientID;

@end
