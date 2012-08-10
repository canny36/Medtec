//
//  NewEncountersViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 10/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "NewEncountersViewController.h"
#import "AppHeaderView.h"
#import "TdCalendarView.h"
#import "JSON.h"
#import "GetProviderIDs.h"
#import "Medtec_medical_incAppDelegate.h"
#import "EncounterTableCell.h"
#import "EditEncountersViewController.h"
#import "AccessoryTableViewCell.h"
#import "Provider.h"
#import "SignatureView.h"

@interface NewEncountersViewController()
    
-(void)onDeliveryTypeSelection:(UIButton*)btn;
-(void)onCASelection:(UIButton*)btn;
-(void)oniiSelection:(UIButton*)btn;
-(void)onPurchaseTypeSelection:(UIButton*)btn;
-(void)fillPatientInfo:(PatientInfo*)info;

@end

@implementation NewEncountersViewController
@synthesize patientId,patientDictionary,info;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldsResignMethod];
}
-(void)textFieldsResignMethod
{
    
  
}


-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)dealloc
{
    [createEncounterDict release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];*/
    if (info != nil) {
      [self fillPatientInfo:info];
    }
   
    
    [bgScrollView setContentSize:CGSizeMake(965, 850)];
    appDelegate=(Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    //adding calender view
    tdView=[[TdCalendarView alloc]initWithFrame:CGRectMake(400, 2000, 320, 260)];
    tdView.backgroundColor=[UIColor colorWithRed:210/255.0 green:209/255.0 blue:213/255.0 alpha:1.0];
    tdView.calendarViewDelegate=self; 
    createEncounterDict=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    //[self testData];
    equipResponseDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    equipPickerArray=[[NSMutableArray alloc] init];
    pickerIndex=0;
    [self.view addSubview:equipPicker];
    equipPicker.center = CGPointMake(self.view.frame.size.width/2, 2000);
    
    [self.view addSubview:toolBar];
    toolBar.center = CGPointMake(self.view.frame.size.width/2, 2000);
    //[self getPracticeEquipments];
   
    
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveencounter)];
    self.navigationItem.rightBarButtonItem = rightB;
    [rightB release];   
    
    
    diagnosisCodeArray=[[NSMutableArray alloc] init];
    drugArray=[[NSMutableArray alloc] init];
    jCodeArray=[[NSMutableArray alloc] init];
    
    
    [diagnosisCodeArray addObject:@"153.9 Carcinoma,Colon"];
    [diagnosisCodeArray addObject:@"174.9 Carcinoma,Breast"];
    [diagnosisCodeArray addObject:@"151.9 Carcinoma,Stomach"];
    [diagnosisCodeArray addObject:@"154.0 Carcinoma,Colorectal"];
    [diagnosisCodeArray addObject:@"154.1 Carcinoma,Rectal"];
    [diagnosisCodeArray addObject:@"150.9 Carcinoma,Esophageal"];
    [diagnosisCodeArray addObject:@"154.3 Carcinoma,Anal"];
    [diagnosisCodeArray addObject:@"203.00 Myeloma, Multiple"];
    
    
    [drugArray addObject:@"5-FU,500mg"];
    [drugArray addObject:@"Mesna,200mg"];
    [drugArray addObject:@"Cisplatin,10mg"];
    [drugArray addObject:@"Doxorubicin HCL,10mg"];
    [drugArray addObject:@"Cladri bine, 1 mg"];
    
    
    [jCodeArray addObject:@"J9190"];
    [jCodeArray addObject:@"J9209"];
    [jCodeArray addObject:@"J9060"];
    [jCodeArray addObject:@"J9000"];
    [jCodeArray addObject:@"J9065"];
}


#pragma mark -Save Encounter

-(void)saveencounter
{
    
    NSLog(@"\nSave Encounter");
    
    SignatureView *sigView=[[SignatureView alloc] initWithFrame:CGRectMake(300, 100, 400, 400)];
    //sigView.backgroundColor=[UIColor redColor];
    [self.view addSubview:sigView];
    
    
    
    
    
}



#pragma mark -  Pop View

-(IBAction)toolBar_cancelAction:(id)sender
{
    [self popView:2000];
}
-(IBAction)toolBar_saveAction:(id)sender
{
    /*if(storeTextField == dobTxt)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"MM/dd/YYYY"];
        NSString *selected = [dateFormatter stringFromDate:[dobPicker date]];
        dateTxtField.text = selected;
    }*/
   
    [self popView:2000];
    
    
}


-(void)popView:(int)value
{
    NSArray *a = [popupView subviews];
    if([a count])
        for(int i=0;i<[a count];i++)
            [[a objectAtIndex:i]removeFromSuperview];
    [self.view addSubview:popupView];
    popupView.backgroundColor = [UIColor clearColor];
    
//    if((storeTextField == dateTxtField) || (storeTextField == startRefillDateTxtField) || (storeTextField==equipDeliveryTxtField)||(storeTextField == equipRcvdTxtField)||(storeTextField == dmeifInitialDateTxtField)||(storeTextField == dmeifRevisedDateTxtField)||(storeTextField == dmeifRecertificationDateTxtField))
    
    if(storeTextField == startDateTxtField)
    {        
        [popupView addSubview:tdView];
        tdView.frame = CGRectMake(402, 0, tdView.frame.size.width, tdView.frame.size.height);
    }
    
    if(storeTextField == providerTxtField)
    {
        picker.tag=PICKER_PROVIDER;
        [popupView addSubview:toolBar];
        toolBar.frame = CGRectMake(402, 0, toolBar.frame.size.width, toolBar.frame.size.height);
        
        [popupView addSubview:picker];
        picker.frame = CGRectMake(402, toolBar.frame.size.height+toolBar.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
         [picker reloadAllComponents];
    }  
    
    else if(storeTextField == diagnosisCodeTxtField)
    {
        picker.tag=PICKER_DIAGNOSIS;
        [popupView addSubview:toolBar];
        toolBar.frame = CGRectMake(402, 0, toolBar.frame.size.width, toolBar.frame.size.height);
        
        [popupView addSubview:picker];
        picker.frame = CGRectMake(402, toolBar.frame.size.height+toolBar.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
         [picker reloadAllComponents];
    }    
    else if(storeTextField == jCodeTxtField)
    {
        picker.tag=PICKER_JCODE;
        [popupView addSubview:toolBar];
        toolBar.frame = CGRectMake(402, 0, toolBar.frame.size.width, toolBar.frame.size.height);
        
        [popupView addSubview:picker];
        picker.frame = CGRectMake(402, toolBar.frame.size.height+toolBar.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
         [picker reloadAllComponents];
    } 
    
    else if(storeTextField == drugTxtField)
    {
        picker.tag=PICKER_DRUG;
        [popupView addSubview:toolBar];
        toolBar.frame = CGRectMake(402, 0, toolBar.frame.size.width, toolBar.frame.size.height);
        
        [popupView addSubview:picker];
        picker.frame = CGRectMake(402, toolBar.frame.size.height+toolBar.frame.origin.y, picker.frame.size.width, picker.frame.size.height);
        
        [picker reloadAllComponents];
    }  

    
    
    
    popupView.frame =  CGRectMake(0, 2000, popupView.frame.size.width, popupView.frame.size.height);
    CGRect viewFrame = CGRectMake(0, value, popupView.frame.size.width, popupView.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[popupView setFrame:viewFrame];
	[UIView commitAnimations];
    [self.view bringSubviewToFront:popupView];
    
    
        
  
    
}

- (void) selectDateChanged:(CFGregorianDate) selectDate
{
    
}

- (void) monthChanged:(CFGregorianDate) currentMonth viewLeftTop:(CGPoint)viewLeftTop height:(float)height
{
	/////////////
    //NSLog(@"HIIIIIIIII");
}
- (void) beforeMonthChange:(TdCalendarView *) calendarView willto:(CFGregorianDate) currentMonth
{
	
}
- (void)go:(NSString *)selectedDate
{	
	flag=FALSE;
    [self popView:2000];
    NSLog(@"Date in search patient view is %@",selectedDate);
    storeTextField.text = selectedDate;
    
}

#pragma mark - TextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     
//    if (textField == equipIdTxtField) 
//    {  
//        [textField resignFirstResponder];
//        //[self viewanimation:100];
//        [self pickerViewanimation:490 :446];
//    }
    
//     if(textField == startDateTxtField)
//    {
//        [storeTextField resignFirstResponder];
//        [textField resignFirstResponder];
//        [self popView:400];
//    }
//    else
//    {
//        [self popView:2000];
//    }
//    
    ////// Adding Pickers
    
    storeTextField = textField;
    if((textField == jCodeTxtField) || (textField == providerTxtField) || (textField == drugTxtField) || (textField == diagnosisCodeTxtField)||textField == startDateTxtField) 
    {
        [storeTextField resignFirstResponder];
        [textField resignFirstResponder];
        [self popView:400];
    }
    else
        [self popView:2000];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
   // previousTxtField = textField;
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    storeTextField = textField;
    
    
    if((textField == jCodeTxtField) || (textField == providerTxtField) || (textField == drugTxtField) || (textField == diagnosisCodeTxtField)||(textField == startDateTxtField)) 
    {
        [textField resignFirstResponder];
        [self popView:400];
        return NO;
    }
    else
        [self popView:2000]; 

    return YES;
}

/*
- (BOOL)textField:(UITextField *)textField2 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
   
	if((textField2==equipIdTxtField)||(textField2==ptnTimesTxtField)||(textField2==ptnDaysTxtField)|| (textField2 ==ptnAdminIfnoTxtField)|| (textField2==estimatedTreatDurationTxtField))
    {
		BOOL isNumeric=NO;
		if ([string length] == 0) 
		{
			isNumeric=YES;
		}
		else
		{
			
			if ( [string compare:[NSString stringWithFormat:@"%d",0]]==0 || [string compare:[NSString stringWithFormat:@"%d",1]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",2]]==0 || [string compare:[NSString stringWithFormat:@"%d",3]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",4]]==0 || [string compare:[NSString stringWithFormat:@"%d",5]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",6]]==0 || [string compare:[NSString stringWithFormat:@"%d",7]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",8]]==0 || [string compare:[NSString stringWithFormat:@"%d",9]]==0)
			{
				isNumeric=YES;
			}
		}		
		
		return isNumeric;
		
        
    }
    
	return YES;
	
}*/

#pragma mark - Validation

-(void)checkValidation
{
    validationSuccess = YES;
    //    if ([[registerRequestDict objectForKey:@"FirstName"] length] <1)
    
 
    if([providerTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Provider ID" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    else if([diagnosisCodeTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter DiagnosisCode " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    else if([estimatedTreatDurationTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Estimated Treatment Duration" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }

    
    else if([typeOfInfusionPumpTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Type Of Infusion " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([drugTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Drug used in pump" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([startDateTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Start Date " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([pumpSerialTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Pump Serial  " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([hcpcsCodeTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter HCPCSCode" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    else if([jCodeTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter jCode " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
        else if([diagnosisCodeTxtField.text length] < 1)
    {
        validationSuccess = NO;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Enter Diagnosis Code " delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }  
    
   
                
      
}



#pragma mark Webservices


-(IBAction)saveEncounter
{
   
//    if(appDelegate.isNetworkIsAvailable==NO)
//    {
//        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
//        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:@"Network Status" message:@"Sorry, network is not available. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alertNetwork show];
//        [alertNetwork release];
//        return;
//        
//    }
//    else
//    {
        [self checkValidation]; 
        if (validationSuccess == YES)
        {
            [self addDataToDictionary];
            [self createRequestForNewEncounter];
        }   
    //}
    
}


//TBD


-(void)testData
{
  /*  equipIdTxtField.text =@"5";
    dateTxtField.text=@"07/26/2012";
    equipOptionsTxtField.text =@"purchase";
    prescribePhysicianTxtField.text=@"Hamad";
    deliveryMethodTxtField.text=@"shipping service";
    startRefillDateTxtField.text=@"07/19/2012";
    equipInspectedTxtField.text=@"test";
    equipDeliveryTxtField.text=@"07/28/2012";
    facilityNameTxtField.text=@"JIM KILCRAN";
    facilityAddressTxtField.text=@"114";
    diagnosisCodeTxtField.text=@"150,colon";
    estimatedTreatDurationTxtField.text=@"10";
    serialNumberTxtField.text=@"123456";
    typeOfEquipTxtField.text=@"infusion pump"; 
    drugTxtField.text=@"test drug";
    hcpcsCodeTxtField.text=@"j9190";
    jCodeTxtField.text=@"j9190 5-FU,500mg";
    beneficiaryNameTxtField.text=@"george";
    ptnPhysicianNameTxtField.text=@"hamad";
    ptnTimesTxtField.text =@"1";
    ptnDaysTxtField.text =@"7";
    ptnAdminTxtField.text=@"1";
    ptnInfusionTxtField.text=@"1";
    ptnEquipTxtField.text=@"Ambit";    
    dmeifInitialDateTxtField.text=@"07/21/2012";
    dmeifRevisedDateTxtField.text=@"07/24/2012"; 
    dmeifRecertificationDateTxtField.text=@"07/24/2012";  */ 
    
}



-(void)addDataToDictionary
{
  /*  [createEncounterDict setObject:@"1" forKey:@"StatusID"];  
    [createEncounterDict setObject:patientId forKey:@"PatientID"];
    [createEncounterDict setObject:equipIdTxtField.text  forKey:@"EquipID"];
    [createEncounterDict setObject:dateTxtField.text  forKey:@"Date"];
    [createEncounterDict setObject:equipOptionsTxtField.text  forKey:@"Equip_Options"];
    [createEncounterDict setObject:prescribePhysicianTxtField.text forKey:@"Presc_Physician"];
    [createEncounterDict setObject:deliveryMethodTxtField.text forKey:@"Delivery_Method"];
    [createEncounterDict setObject:startRefillDateTxtField.text forKey:@"Start_Refill_Date"];
    [createEncounterDict setObject:equipInspectedTxtField.text forKey:@"Equip_Inspected_By"]; 
    [createEncounterDict setObject:equipDeliveryTxtField.text  forKey:@"Equip_Deliv_Date"];
    [createEncounterDict setObject:facilityNameTxtField.text forKey:@"Facility_Name"];    
    [createEncounterDict setObject:facilityAddressTxtField.text forKey:@"Facility_Address"];    
    [createEncounterDict setObject:diagnosisCodeTxtField.text forKey:@"Diagnosis_Codes"];  
     [createEncounterDict setObject:serialNumberTxtField.text  forKey:@"Equip_Serial_Num"];
    [createEncounterDict setObject:estimatedTreatDurationTxtField.text  forKey:@"Est_Treatment_Dur"];
    [createEncounterDict setObject:typeOfEquipTxtField.text  forKey:@"Type_Of_Equip"];
    [createEncounterDict setObject:drugTxtField.text  forKey:@"Drug"];
    [createEncounterDict setObject:hcpcsCodeTxtField.text  forKey:@"HCPCS_Code"];
    [createEncounterDict setObject:jCodeTxtField.text forKey:@"J_Code"];    
    [createEncounterDict setObject:equipRcvdTxtField.text forKey:@"Po_Equip_Received_Date"];    
    [createEncounterDict setObject:beneficiaryNameTxtField.text forKey:@"Mcr_Beneficiary_Name"];
    [createEncounterDict setObject:mcrNotesTxtField.text forKey:@"Mcr_Notes"];
    [createEncounterDict setObject:pdrLegalGuardTxtField.text forKey:@"Pdr_Legalguardian_Sign"];
    [createEncounterDict setObject:piiGuardRelationTxtField.text forKey:@"Pii_Guardian_Relation"];
    [createEncounterDict setObject:piiGuardFirstNameTxtField.text forKey:@"Pii_Guardian_Firstname"];
    [createEncounterDict setObject:piiGuardLastNameTxtField.text forKey:@"Pii_Guardian_Lastname"];
    [createEncounterDict setObject:piiGuardAdd1TxtField.text forKey:@"Pii_Guardian_Address1"];
    [createEncounterDict setObject:piiGuardAdd2TxtField.text forKey:@"Pii_Guardian_Address2"];
    [createEncounterDict setObject:piiGuardCityTxtField.text forKey:@"Pii_Guardian_City"];
    [createEncounterDict setObject:piiGuardStateTxtField.text forKey:@"Pii_Guardian_State"];
    [createEncounterDict setObject:piiGuardZipTxtField.text forKey:@"Pii_Guardian_Zip"];
    [createEncounterDict setObject:piiGuardEmailTxtField.text forKey:@"Pii_Guardian_Email"];
    [createEncounterDict setObject:piiGuardPhoneTxtField.text forKey:@"Pii_Guardian_Phone"];
    [createEncounterDict setObject:ptnPhysicianNameTxtField.text forKey:@"Ptn_Physician_Name"];
    [createEncounterDict setObject:ptnTimesTxtField.text forKey:@"Ptn_Intravenous_Conti_Times"];
    [createEncounterDict setObject:ptnDaysTxtField.text forKey:@"Ptn_Intravenous_Conti_Days"];
    [createEncounterDict setObject:ptnAdminTxtField.text forKey:@"Ptn_Continu_Administrat"];
    [createEncounterDict setObject:ptnAdminIfnoTxtField.text forKey:@"Ptn_Continu_Adminstrat_IFno"];
    [createEncounterDict setObject:ptnInfusionTxtField.text forKey:@"Ptn_Intravenous_Infusion"];
    [createEncounterDict setObject:ptnEquipTxtField.text forKey:@"Ptn_Presc_Of_Equip"];
    [createEncounterDict setObject:dmeifInitialDateTxtField.text forKey:@"Dmeif_Initial_Date"];
    [createEncounterDict setObject:dmeifRevisedDateTxtField.text forKey:@"Dmeif_Revised_Date"];
    [createEncounterDict setObject: dmeifRecertificationDateTxtField.text forKey:@" Dmeif_Recertification_Date"];*/
    
    
}




-(void) createRequestForNewEncounter
{
    //[createEncounterDict setObject:@"1" forKey:@"StatusID"];
 
    NSLog(@"\nCreateEncounterDict dict = %@",createEncounterDict);
    
    id jsonRequest = [createEncounterDict JSONRepresentation];
    
    NSURL *url = [NSURL URLWithString:@"http://www.medtecp3.com/MedtecMobilesServices/CreatePatientNewEncounter"];
    
    urlRequest = [NSMutableURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];        
    
    NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [urlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];        
    [urlRequest setHTTPBody:requestData];
    // NSLog(@"%@",requestData);
    
    if (urlConnection != nil)
    {
        [urlConnection release];
    }
    
    urlConnection = [[NSURLConnection alloc]initWithRequest:urlRequest delegate:self];
    
    if (webServiceData != nil ) {
        [webServiceData release];
    }
    webServiceData = [[NSMutableData data] retain];	
    
    if (timer  != nil)
    {
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cancelConnection:) userInfo:urlConnection repeats:NO];
    
    
}   

-(void)getPracticeEquipments
{
    
    NSMutableDictionary *questionDict = [[NSMutableDictionary alloc]init];
    //[questionDict setObject:@"1" forKey:@"PracticeID"];
    
    [questionDict setObject:[global_userDetails objectForKey:@"PracticeID"] forKey:@"PracticeID"];    
    
    id jsonRequest = [questionDict JSONRepresentation];   
    
    NSLog(@"\ngetPracticeEquipments request is %@",questionDict);
    
    //    NSURL *url = [NSURL URLWithString:@"http://192.168.1.100/TestingApps/MedtecMobilesServices/DeletePatientInfo"];    
    
    NSURL *url = [NSURL URLWithString:@"http://www.medtecp3.com/MedtecMobilesServices/GetPracticeEquipments"];
    
    equipRequest = [NSMutableURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *searchPatientdeleteData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [equipRequest setHTTPMethod:@"POST"];
    [equipRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [equipRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [equipRequest setValue:[NSString stringWithFormat:@"%d", [searchPatientdeleteData length]] forHTTPHeaderField:@"Content-Length"];        
    [equipRequest setHTTPBody: searchPatientdeleteData];    
    dataConnection =[[NSURLConnection alloc] initWithRequest:equipRequest delegate:self];    
    equipWebServiceData = [[NSMutableData data] retain];

}

-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    
    if (aConnection==dataConnection) 
    {
        [equipWebServiceData appendData:data]; 
    }
    else
    {
    encounterDataReceived = YES;   
    [webServiceData appendData:data]; 
    }
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    if (aConnection==dataConnection) 
    {
      [equipWebServiceData setLength:0]; 
    }
    else
    {
       [webServiceData setLength:0];  
    }
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    if (connection==dataConnection) 
    {
        
    }
    else
    {
        if (urlConnection!=nil) 
        {
            [urlConnection release];
        }        
        if (webServiceData!=nil) 
        {
            [webServiceData release];
        }
    }
	NSLog(@"Error is %@",error);	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{    
    if (aConnection==dataConnection)
    {
        NSString *strResponse = [[NSString alloc]initWithData:equipWebServiceData encoding:NSUTF8StringEncoding];
        
        NSLog(@"\nstrResponse =%@",strResponse);
        if (strResponse !=nil && [strResponse length] >0) 
        {
            SBJSON *json = [[SBJSON new] autorelease];    
            id result = [json objectWithString:strResponse error:nil];
            [equipResponseDict removeAllObjects];
            [equipPickerArray removeAllObjects];
//            if ([result isKindOfClass:[NSDictionary class]]) 
//                [equipResponseDict addEntriesFromDictionary:(NSDictionary *)result];
           
             if ([result isKindOfClass:[NSArray class]] && [result count] >0) 
                //[equipResponseDict addEntriesFromDictionary:[result objectAtIndex:0]];
                //equipPickerArray=result;
                 [equipPickerArray addObjectsFromArray:result];
            NSLog(@"EquipArray is %@",equipPickerArray);
            
            if ([equipPickerArray count] >0)
            {                
                for (int i=0; i<[equipPickerArray count]; i++) 
                {
                    NSLog(@".....Equippicker array count is %d and array is %@",[equipPickerArray count],equipPickerArray);
                    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc] initWithCapacity:0];
                    tempDict=[equipPickerArray objectAtIndex:i];
                    NSLog(@"TempDict is %@",tempDict);
                    [equipPickerArray addObject:[tempDict objectForKey:@"Equip_Name"]];
                }                
                [equipPicker reloadAllComponents];
            }
            
            NSLog(@"Arr count is %d",[equipPickerArray count]);
            
        }
        
    }
    else
    {
        NSString *strResponse = [[NSString alloc]initWithData:webServiceData encoding:NSUTF8StringEncoding];
        
        NSLog(@"\nstrResponse =%@",strResponse);
        
        if (strResponse !=nil && [strResponse length] >0) 
        {
            SBJSON *json = [[SBJSON new] autorelease];    
            id result = [json objectWithString:strResponse error:nil];
                    
            NSString *responseString = [result objectForKey:@"Status"];
            NSLog(@"\nResult  from server is %@",responseString);
            if ([responseString isEqualToString:@"Success"])
            {
                UIAlertView *resultAlert = [[UIAlertView alloc] initWithTitle:@"Created New Patient Encounter Successfully" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];                
                [resultAlert show];
                [resultAlert release];
                //[self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                UIAlertView *resultAlert = [[UIAlertView alloc] initWithTitle:@"Encounter Creation Failed" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [resultAlert show];
                [resultAlert release];
            }
        }    
    }
      
}


-(void)cancelConnection:(NSTimer *)myTimer
{
    NSURLConnection *tempConnection = [myTimer userInfo];
    if([tempConnection isEqual:urlConnection])
    {
        if (encounterDataReceived == NO)
        {
            [urlConnection cancel];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
        timer = nil;
    }
    
}

#pragma mark - fill patient details
-(void)fillPatientInfo:(PatientInfo*)_info{
    
    
    patientName.text=_info.firstname;
    lastName.text=_info.lastname;
    dob.text=_info.dob;
    phoneNo.text= [NSString stringWithFormat:@"%d",_info.phoneNo];
    
    
}



#pragma mark -Table view delegate methods


//////////// Table view data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== encounterListTable) 
                return 3;
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     if (tableView== encounterListTable) 
            return 44;
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView== encounterListTable) 
    {
        static NSString *customCellIdentifier =@"CustomCellIdentifier";
        //NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
       EncounterTableCell *cell = (EncounterTableCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
        if (cell==nil) 
        {          
            NSArray *topObject=[[NSBundle mainBundle] loadNibNamed:@"EncounterTableCell" owner:nil options:nil];
            for (id object in topObject) 
            {
                if ([object isKindOfClass:[EncounterTableCell class]]) {
                    cell =(EncounterTableCell *)object;
                }
            }						
            
        } 
        switch (indexPath.row) 
        {
                case 0:
                {
                    cell.visitDate.text =@"8/5/2012";
                    cell.providerName.text=@"Dr Smith";
                    cell.visitCounter.text=@"3";
                    cell.encStatus.text=@"Pending";
                    cell.pSign.text=@"yes";
                    cell.mdSign.text=@"no";
                    cell.messageFromBiller.text=@"Please sign and submit"; 
                }
                break;
                case 1:
                {
                    cell.visitDate.text =@"7/15/2012";
                    cell.providerName.text=@"Dr Smith";
                    cell.visitCounter.text=@"2";
                    cell.encStatus.text=@"Submitted";
                    cell.pSign.text=@"yes";
                    cell.mdSign.text=@"yes";
                    cell.messageFromBiller.text=@""; 
                }
                break;
                case 2:
                {
                    cell.visitDate.text =@"6/6/2012";
                    cell.providerName.text=@"Dr Smith";
                    cell.visitCounter.text=@"1";
                    cell.encStatus.text=@"Submitted";
                    cell.pSign.text=@"yes";
                    cell.mdSign.text=@"yes";
                    cell.messageFromBiller.text=@"Add Emergency Contact"; 
                }
                break;
                
            default:
                break;
        }     
        
        return cell;

    }
    
    else if(tableView==accessoryTable)
    {
        static NSString *customCellIdentifier =@"CustomCellIdentifier";
          AccessoryTableViewCell *cell=(AccessoryTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
        if (cell==nil) 
        {          
            NSArray *topObject=[[NSBundle mainBundle] loadNibNamed:@"AccessoryTableViewCell" owner:nil options:nil];
            for (id object in topObject) 
            {
                if ([object isKindOfClass:[AccessoryTableViewCell class]]) {
                    cell =(AccessoryTableViewCell *)object;
                }
            }						
            
        } 
        switch (indexPath.row) 
        {
            case 0:
            {
                //[cell.accessoryButton setImage:[UIImage imageNamed:@"CheckBoxHL.png"] forState:UIControlStateNormal];
                cell.accessoryName.text=@"Cassette";
                cell.quantity.text=@"01";
                cell.manufacturer.text=@"Summit Medical";
                cell.part.text=@"220139";                
            }
                break;
            case 1:
            {
                cell.accessoryName.text=@"Batteries";
                cell.quantity.text=@"02";
                cell.manufacturer.text=@"Panasonic";
                cell.part.text=@"AA";                
            }
                break;
            case 2:
            {
                cell.accessoryName.text=@"Drug Baq";
                cell.quantity.text=@"01";
                cell.manufacturer.text=@"Metric Co";
                cell.part.text=@"58719";                
            }
                break;
            case 3:
            {
                cell.accessoryName.text=@"Carry Pouch";
                cell.quantity.text=@"01";
                cell.manufacturer.text=@"Summit Medical";
                cell.part.text=@"220409";
            }
                break;
            default:
                break;
        }     
        
         return cell;
    }
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == accessoryTable) {
        AccessoryTableViewCell *cell = (AccessoryTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
        cell.tag = !cell.tag;
        [cell.accessoryButton setImage: [UIImage imageNamed:cell.tag ==1 ? @"CheckBoxHL.png" :@"checkBox.png"] forState:UIControlStateNormal];
    }
   
    
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row %2 ==0)
    {
        cell.backgroundColor=[UIColor colorWithRed:(208.0/255.0) green:(216.0/255.0) blue:(232.0/255.0) alpha:1.0];
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithRed:(233.0/255.0) green:(237.0/255.0) blue:(244.0/255.0) alpha:1.0];   
    }
    
    
}



#pragma mark - PickerView Delegate METHODS

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *title = @"";
    int tag = pickerView.tag;
    switch (tag) {
        case PICKER_PROVIDER:
        {         
            Provider *provider =  [appDelegate.providersArray objectAtIndex:row];
            title = provider.fullName;
            providerTxtField.text=title;
        }
            break;
        case PICKER_JCODE:
            title = [jCodeArray objectAtIndex:row];
            jCodeTxtField.text=title;
            break;
        case PICKER_DIAGNOSIS:
            title = [diagnosisCodeArray objectAtIndex:row];
            diagnosisCodeTxtField.text=title;
            break;
        case PICKER_DRUG:
            title = [drugArray objectAtIndex:row];
            drugTxtField.text=title;
            break;
        default:
            break;
    }


}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    int count = 0;
    int tag = pickerView.tag;
    switch (tag) {
        case PICKER_PROVIDER:
            count = [appDelegate.providersArray count];
            break;
        case PICKER_JCODE:
            count = [jCodeArray count];
            break;
        case PICKER_DIAGNOSIS:
            count = [diagnosisCodeArray count];
            break;
        case PICKER_DRUG:
            count = [drugArray count];
            break;
        default:
            break;
    }
	
	return count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{ 
    NSString *title = @"";
    int tag = pickerView.tag;
    switch (tag) {
        case PICKER_PROVIDER:
        {
            Provider *provider =  [appDelegate.providersArray objectAtIndex:row];
            title = provider.fullName;
        }
            break;
        case PICKER_JCODE:
           title = [jCodeArray objectAtIndex:row];
            break;
        case PICKER_DIAGNOSIS:
            title = [diagnosisCodeArray objectAtIndex:row];
            break;
        case PICKER_DRUG:
            title = [drugArray objectAtIndex:row];
            break;
        default:
            break;
    }
    //NSLog(@"\n.......Title is %@",title);
	
	return title;
}


-(IBAction)DoneAction:(id)sender
{
    [self pickerViewanimation:2000 : 2000];
    [self viewanimation:0];
    //equipIdTxtField.text = [equipPickerArray objectAtIndex:pickerIndex];
}

-(void)viewanimation:(int)value 
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.3];
    bgScrollView.contentOffset = CGPointMake(0, value);
    [UIView commitAnimations];
}

-(void)pickerViewanimation:(int)value :(int)toolValue
{
	CGRect viewFrame = CGRectMake(319, value, equipPicker.frame.size.width, equipPicker.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[equipPicker setFrame:viewFrame];
	[UIView commitAnimations];
    [self.view bringSubviewToFront:equipPicker];
	
	CGRect newToolBarFrame = CGRectMake(319, toolValue, toolBar.frame.size.width, toolBar.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[toolBar setFrame: newToolBarFrame];
	[UIView commitAnimations];	
	
}


#pragma mark - onCheckboxSelection

-(void)onDeliveryTypeSelection:(UIButton*)btn{
    
     NSLog(@" onDeliverySelection ");
    
    if (btn == beneficiaryButton) {
        
        NSLog(@" onDeliverySelection %d",1);
        shippingButton.tag = 0;
        nursingButton.tag=0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [shippingButton setImage:image forState:UIControlStateNormal];
        [nursingButton setImage:image forState:UIControlStateNormal];
    }else if(btn == shippingButton){
           NSLog(@" onDeliverySelection %d",2);
        beneficiaryButton.tag = 0;
        nursingButton.tag=0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [beneficiaryButton setImage:image forState:UIControlStateNormal];
        [nursingButton setImage:image forState:UIControlStateNormal];
    }else if(btn == nursingButton){
           NSLog(@" onDeliverySelection %d",3);
        shippingButton.tag = 0;
        beneficiaryButton.tag=0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [beneficiaryButton setImage:image forState:UIControlStateNormal];
        [shippingButton setImage:image forState:UIControlStateNormal];
    }
}



-(void)onCASelection:(UIButton*)btn{
    
    if (btn == contiAdminNoButton ) {
        contiAdminYesButton.tag = 0;
       UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [contiAdminYesButton setImage:image forState:UIControlStateNormal];
    }else if(btn == contiAdminYesButton){
        contiAdminNoButton.tag = 0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [contiAdminNoButton setImage:image forState:UIControlStateNormal];

    }
}

-(void)oniiSelection:(UIButton*)btn{
    
    if (btn == intravenousInfusionNoButton ) {
        intravenousInfusionYesButton.tag = 0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [intravenousInfusionYesButton setImage:image forState:UIControlStateNormal];
    }else if(btn == intravenousInfusionYesButton){
        intravenousInfusionNoButton.tag = 0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [intravenousInfusionNoButton setImage:image forState:UIControlStateNormal];
        
    }
}

-(void)onPurchaseTypeSelection:(UIButton*)btn{
    
    if (btn == rentButton ) {
       buyButton.tag = 0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [buyButton setImage:image forState:UIControlStateNormal];
    }else if(btn == buyButton){
        rentButton.tag = 0;
        UIImage *image = [UIImage imageNamed:@"checkBox.png"];
        [rentButton setImage:image forState:UIControlStateNormal];
    }
}


#pragma mark - checkbox actions

-(IBAction)rentalAction:(id)sender{
    
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
      [self onPurchaseTypeSelection:btn];
   
}

-(IBAction)buyAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
    [self onPurchaseTypeSelection:btn];
}

-(IBAction)caYesAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
    [self onCASelection:btn];
}

-(IBAction)caNoAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    [self onCASelection:btn];

}

-(IBAction)iiYESAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
    [self oniiSelection:btn];
}

-(IBAction)iiNoAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
     [self oniiSelection:btn];
}

-(IBAction)ambitAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
}


-(IBAction)dtodDeliveryAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
    [self onDeliveryTypeSelection:btn];
    
}

-(IBAction)ssDeliveryAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
     [self onDeliveryTypeSelection:btn];
}

-(IBAction)tnfDeliveryAction:(id)sender{
    UIButton *btn = (UIButton*)sender;
    btn .tag = !btn.tag; 
    BOOL isSelectd = btn.tag == 0 ? NO : YES;
    NSString *imgname = isSelectd == YES ? @"CheckBoxHL.png":@"checkBox.png";
    [btn setImage:[UIImage imageNamed:imgname] forState:UIControlStateNormal];
    
     [self onDeliveryTypeSelection:btn];
}




#pragma mark - NewEncounter
-(IBAction)newEncounter:(id)sender
{
    NewEncountersViewController *newEncountersViewController = [[NewEncountersViewController alloc] initWithNibName:@"EncounterViewController" bundle:nil];
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
}

#pragma mark - EditEncounter

-(IBAction)editEncounter:(id)sender
{
    EditEncountersViewController *newEncountersViewController = [[EditEncountersViewController alloc] initWithNibName:@"EditEncounterViewController" bundle:nil];       
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
 
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

@end
