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
#import "MedTecNetwork.h"
#import "Accessory.h"

@interface NewEncountersViewController()
    
-(void)onDeliveryTypeSelection:(UIButton*)btn;
-(void)onCASelection:(UIButton*)btn;
-(void)oniiSelection:(UIButton*)btn;
-(void)onPurchaseTypeSelection:(UIButton*)btn;
-(void)fillPatientInfo:(PatientInfo*)info;
-(NSMutableDictionary*)createRequestForNewEncounter1;
-(NSString*)checkValidation;
-(void)showAlert:(NSString*)message;
-(void)initDefaults;
-(void)getPracticeEquipments;
-(void)showProgress :(NSString*)message;
-(void)hideProgress;
-(void)getEncounters;
-(void)getAccessories;

@end


#define DELIVERY_NURING @"to nursing facility"
#define DELIVERY_SHIPPING @"Shipping service"
#define DELIVERY_DTOB @"directly to beneficiary"

@implementation NewEncountersViewController

static UIImage *checkedImage;
static UIImage *uncheckedImage;

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
    [progressAlert release];
    
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
    
    [self initDefaults];
    
        
    [bgScrollView setContentSize:CGSizeMake(965,650)];
    appDelegate=(Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication]delegate];
    
       
    //adding calender view
    tdView=[[TdCalendarView alloc]initWithFrame:CGRectMake(400, 2000, 320, 260)];
    tdView.backgroundColor=[UIColor colorWithRed:210/255.0 green:209/255.0 blue:213/255.0 alpha:1.0];
    tdView.calendarViewDelegate=self; 
    createEncounterDict=[[NSMutableDictionary alloc] initWithCapacity:0];
    

    
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


#pragma mark -
#pragma mark - Init defaults

-(void)initDefaults{
    
    
   int enc_count =  info.encountersCount;
    if (enc_count == 0) {
        encounterListTable.hidden = YES;
        encounterHeadedView.hidden = YES;
     CGRect frame =  bgScrollView.frame;
        frame.origin.y = 220;
        bgScrollView.frame = frame;
    }else{
        encounterListTable.dataSource = self;
        encounterListTable.delegate = self;
        
       
        
    }
    
     [self getEncounters];
    
    if (appDelegate.accessoryArray != nil) {
        [accessoryTable reloadData];
    }else{
        [self getAccessories];
    }
  
   checkedImage = [UIImage imageNamed:@"CheckBoxHL.png"];
   uncheckedImage = [UIImage imageNamed:@"checkBox.png"];
    
   hcpcsCodeTxtField.text = @"E0781";   
   providerTxtField.tag = -1;
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"MM/dd/yyyy" options:0 locale:usLocale];
   NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = dateFormat;
    
    
   NSDate *today = [NSDate date];
    
   NSString *todayDateString =   [formatter stringFromDate:today];
    
    
    startDateTxtField.text = todayDateString;
    
    contiAdminYesButton.tag = 1;
    contiAdminNoButton.tag =0;
    
    intravenousInfusionNoButton.tag = 0;
    intravenousInfusionYesButton.tag =1;
    
    typeOfInfusionPumpTxtField.text = @"ambit";
    
    rentButton.tag = 1;
    [rentButton setImage:checkedImage forState :UIControlStateNormal];
    
    nursingButton.tag = 1;
    [nursingButton setImage:checkedImage forState:UIControlStateNormal ];
    
    [self onDeliveryTypeSelection:nursingButton];
     
}

#pragma mark -Save Encounter

-(void)saveencounter
{
    
  NSString *invalidField =  [self checkValidation];
    if (![invalidField isEqualToString:@""]) {
        [self showAlert:invalidField];
        return;
    }else{
        
        [self showProgress:@"Sending .."];
        
        NSMutableDictionary *bundle = [self createRequestForNewEncounter1];
        MedTecNetwork *medtectNetwork = [[MedTecNetwork alloc]init];
        
        [medtectNetwork createPatientNewEncounter:bundle :self];
    }
  
}


-(void)getALLEquipments{
    MedTecNetwork *medtecNetwork = [[MedTecNetwork alloc]init];
    
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
   int practiceId = [appDelegate loginInfo].practiceID;
    
    [bundle setValue:[NSNumber numberWithInt:practiceId] forKey:@"PracticeID"];
    [medtecNetwork getAllEquipments:bundle :self];
}


-(void)getEncounters{
    MedTecNetwork *medtecNetwork = [[MedTecNetwork alloc]init];
    
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];

    
     [bundle setObject: [NSNumber numberWithInt:info.patientId] forKey:@"PatientID"];
    [medtecNetwork getPatientAllEncounters:bundle :self];
}


-(void)getAccessories{
    MedTecNetwork *medtecNetwork = [[MedTecNetwork alloc]init];
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    [bundle setObject: [NSNumber numberWithInt:5] forKey:@"EquipID"];
    [medtecNetwork getAccessories:bundle :self];
}

#pragma mark -network delegates

-(void)onSuccess:(id)result:(int)call{
    
    NSLog(@"Successfully recieved data for call %d ",call  );
    [self hideProgress];
    
    
    switch (call) {
        case CALL_CREATE_NEW_ENCOUNTER:
//            {"ID":11,"Status":"Success"}
            
            if ([result isKindOfClass:[NSDictionary class]]) {
                NSDictionary *bundle = (NSDictionary*)result;
                NSString *val = [bundle objectForKey:@"Status"];
                if ( val != nil && [val isEqualToString:@"Success"]) {
                    [self showAlert:@"Success"];
                    return;
                }
            }
            [self showAlert:@"Failed "];
            
            break;
            
        case CALL_EQUIPMENTS:
            break;
            
        case CALL_ACCESSORIES:
            appDelegate.accessoryArray = [Accessory collection:result];
            [accessoryTable reloadData];
        default:
            break;
    }
}

-(void)onError:(NSString*)errorMsg :(int)call{
    
    NSLog(@"Failed with response %@ ",errorMsg);
    [self hideProgress];
    switch (call) {
        case CALL_CREATE_NEW_ENCOUNTER:
            
            break;
            
        case CALL_EQUIPMENTS:
            break;
            
        default:
            break;
    }
}

-(void)onConnectionTimeOut{
    
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

-(NSString*)checkValidation
{
    NSString *invalidfField = @"";
    //    if ([[registerRequestDict objectForKey:@"FirstName"] length] <1)
    
 
    if([providerTxtField.text length] < 1)
    {
       invalidfField = @"provider info";

    }else if([diagnosisCodeTxtField.text length] < 1){
        
        invalidfField = @"provider info";
        
    }else if([estimatedTreatDurationTxtField.text length] < 1){
        
        invalidfField = @" Estimated duration of treatment info";
   
    } else if([typeOfInfusionPumpTxtField.text length] < 1){
      invalidfField = @"Type of infusion pump";
        
    } else if([drugTxtField.text length] < 1){
        
         invalidfField = @"drug info";
        
    }
    else if([startDateTxtField.text length] < 1){

        invalidfField = @"todays date";    
    
    } else if([pumpSerialTxtField.text length] < 1){
        
        invalidfField = @"Pump serial ";  

    }else if([hcpcsCodeTxtField.text length] < 1){
        
        invalidfField = @"HCPCS code"; 
        
    }else if([jCodeTxtField.text length] < 1){
        
        invalidfField = @"J code info"; 
        
    }else if([diagnosisCodeTxtField.text length] < 1){
        invalidfField = @"Diagnosis code";
    }  
    
    return invalidfField;
 
}

-(NSMutableDictionary*)createRequestForNewEncounter1{
    
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    if (info != nil) {
        [bundle setValue:[NSNumber numberWithInt:info.patientId] forKey:@"PatientID"];
    }
    
     [bundle setValue:[NSNumber numberWithInt:1] forKey:@"EquipID"];
    
       
    NSString *val = startDateTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Date"];
    }
        
    val = rentButton.tag == 1 ? @"Rental":@"Buy";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Equip_Options"];
    }
    
//    Presc_Physician 
    val = providerTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Presc_Physician"];
    }
    
    if (nursingButton.tag == 1) {
        val = DELIVERY_NURING;
    }else if(beneficiaryButton.tag == 1){
        val = DELIVERY_DTOB;
    }else if(shippingButton.tag == 1){
        val = DELIVERY_SHIPPING;
    }else{
        val = @"";
    }
    
    [bundle setValue:val forKey:@"Delivery_Method"];

  
    [bundle setValue:@"01/01/2012" forKey:@"Start_Refill_Date"];
    [bundle setValue:@"-" forKey:@"Equip_Inspected_By"];
    [bundle setValue:@"01/01/2012" forKey:@"Equip_Deliv_Date"];
    [bundle setValue:@"-" forKey:@"Facility_Name"];
    [bundle setValue:@"-" forKey:@"Facility_Address"];
   
    val = diagnosisCodeTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Diagnosis_Codes"];
    }
 
    val = estimatedTreatDurationTxtField.text;
    if (![val isEqualToString:@""]) {
        int _val = 0;
        @try {
            _val = [val intValue];
        }
        @catch (NSException *exception) {
            _val = 0;
        }
        @finally {
            
        }
        [bundle setValue:[NSNumber numberWithInt:_val] forKey:@"Est_Treatment_Dur"];
    }
    
    val = pumpSerialTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Equip_Serial_Num"];
    }
    
    
    
    
    val = typeOfInfusionPumpTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Type_Of_Equip"];
    }
    
    val = drugTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Drug"];
    }
    
    val = hcpcsCodeTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"HCPCS_Code"];
    }
    
    val = jCodeTxtField.text;
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"J_Code"];
    }
    
   
    val = @" - ";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Mcr_Beneficiary_Name"];
    }
 
    val = @"-";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Ptn_Physician_Name"];
    }
  
    val = @"-";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Ptn_Presc_Of_Equip"];
    }
    
    val = @"04/01/2012";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Dmeif_Initial_Date"];
    }
    
    val = @"04/01/2012";
    if (![val isEqualToString:@""]) {
        [bundle setValue:val forKey:@"Dmeif_Revised_Date"];
    }

    [bundle setValue:[NSNumber numberWithInt:7] forKey:@"Ptn_Intravenous_Conti_Days"];
    
    [bundle setValue:[NSNumber numberWithInt:1] forKey:@"Ptn_Intravenous_Conti_Times"];
    
    int _val = 0;
    if (intravenousInfusionYesButton.tag == 1) {
        _val = 1;
    }
   
    [bundle setValue:[NSNumber numberWithInt:_val] forKey:@"Ptn_Intravenous_Infusion"];
    
    _val = 0;
    if (contiAdminYesButton.tag == 1) {
        _val = 1;
    }
    
    [bundle setValue:[NSNumber numberWithInt:_val] forKey:@"Ptn_Continu_Administrat"];
    
    val = prescriptionPumpAmbitButton.tag == 1 ? @"ambit":@"-";    
    
    [bundle setValue:val forKey:@"Ptn_Presc_Of_Equip"];
    
    return bundle;
    
 }


-(void)showAlert:(NSString*)message{
   message = [NSString stringWithFormat:@"Please enter %@",message];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message: message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    [alert release];
}





#pragma mark - show/hide progress alert 

-(void)showProgress :(NSString*)message
{      
    
    if (progressAlert == nil) {
        progressAlert = [[UIAlertView alloc] initWithTitle: @"" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: nil];
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectMake(219.0f, 20.0f, 37.0f, 37.0f);
        [progressAlert addSubview:activityView];
        [activityView startAnimating];
        [activityView release];
        
    }
    
    progressAlert.message = message;
    [progressAlert show];
}

-(void)hideProgress
{    
    if (progressAlert != nil)
	{
        [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
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
    return appDelegate.accessoryArray != nil ? appDelegate.accessoryArray.count : 0 ;
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
        
        
        Accessory *accessory = [appDelegate.accessoryArray objectAtIndex:indexPath.row];
        
        cell.accessoryName.text = accessory.accessoryName;
        cell.manufacturer.text = accessory.manufacturer;
        cell.part.text = accessory.part;
        cell.quantity.text =[ NSString stringWithFormat:@"%d",accessory.quantity];

        
         return cell;
    }
    
    return nil;
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
            providerTxtField.tag = row;
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
        contiAdminYesButton.tag = (btn.tag == 0) ? 1 : 0;
        int tag = contiAdminYesButton.tag;
        UIImage *image = [UIImage imageNamed:tag == 1 ? @"CheckBoxHL.png":@"checkBox.png"];
      
        [contiAdminYesButton setImage:image forState:UIControlStateNormal];
    }else if(btn == contiAdminYesButton){
        
        contiAdminNoButton.tag = (btn.tag == 0) ? 1 : 0;
        int tag = contiAdminNoButton.tag;
        UIImage *image = [UIImage imageNamed:tag == 1 ? @"CheckBoxHL.png":@"checkBox.png"];
        
        [contiAdminNoButton setImage:image forState:UIControlStateNormal];

    }
}

-(void)oniiSelection:(UIButton*)btn{
    
    if (btn == intravenousInfusionNoButton ) {
        intravenousInfusionYesButton.tag = (btn.tag == 0) ? 1 : 0;
        int tag = intravenousInfusionYesButton.tag;
        UIImage *image = [UIImage imageNamed:tag == 1 ? @"CheckBoxHL.png":@"checkBox.png"];
       
        [intravenousInfusionYesButton setImage:image forState:UIControlStateNormal];
    }else if(btn == intravenousInfusionYesButton){
        intravenousInfusionNoButton.tag = (btn.tag == 0) ? 1 : 0;
        
        int tag = intravenousInfusionNoButton.tag;
        UIImage *image = [UIImage imageNamed:tag == 1 ? @"CheckBoxHL.png":@"checkBox.png"];
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
