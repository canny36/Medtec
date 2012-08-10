//
//  RegisterPatientViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "RegisterPatientViewController.h"
#import "Medtec_medical_incAppDelegate.h"
#import "MainViewController.h"
#import "AppHeaderView.h"
#import "DemographicsView.h"
#import "AppFooterView.h"
//#import "SBJSON.h"
#import "JSON.h"
#import "GetProviderIDs.h"
#import "Provider.h"
#import "MedTecNetwork.h"
#import "Util.h"

#define REGISTER_URL @"http://www.medtecp3.com/MedtecMobilesServices/CreateNewPatient"

@interface RegisterPatientViewController()

-(NSString*)validate;
-(void) showAlert:(NSString*)message:(id<UIAlertViewDelegate>)delegate;
-(void) createRequestForRegistration;
-(NSMutableDictionary*)createRequestBuffer;
-(void)registerPatient:(NSMutableDictionary*)bundle;
-(NSMutableDictionary*)tempReq;
-(void)editPatient:(NSMutableDictionary*)bundle;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;
-(NSString*)getProviderName:(int)providerId;
-(void)showProgress:(NSString*)message;
-(void)hideProgress;

@end

@implementation RegisterPatientViewController

@synthesize fromEditCall;
@synthesize fromEditDict;
@synthesize registerRequestDict;
@synthesize patientInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}



-(void)testdata
{
    
    patientAccNoTxtField.text=@"123";
    firstNameTxtField.text=@"Logictree";
    lastNameTxtField.text=@"Test";
    phoneNo1TxtField.text=@"11111111111";
    ageTxtField.text=@"50";
    genderTxtField.text=@"Male";
    address1TxtField.text=@"Banjara Hills";
    cityTxtField.text=@"Hyderabad";
    stateTxtField.text=@"Andhra Pradesh";
    zipTxtField.text=@"522001";
    dobTxtField.text=@"08/08/1975";
    insurance1IDTxtField.text=@"123";
    hicnTxtField.text=@"1";
//    practiceID=@"1";
       
}



-(IBAction)addOrEditDemography
{
    //NSLog(@"done button clicked:");
    
    //[self testdata];
    
   NSString *invalidField = [self validate];
    if (invalidField != nil) {
        [self showAlert: [NSString stringWithFormat:@"Please enter %@ ",invalidField]:self];
        return;
    }

    NSMutableDictionary *bundle = [self createRequestBuffer];
    if (fromEditCall == NO) {
        [self registerPatient:bundle];
    }else{
        [self editPatient:bundle];
    }

}

#pragma mark - Update view from patientInfo response 

-(void)updatePatientInfo:(NSMutableDictionary*)bundle
{

    firstNameTxtField.text=[self getValue:@"FirstName" :bundle];
    middleNameTxtField.text= [self getValue:@"MiddleName" :bundle];
    lastNameTxtField.text=[self getValue:@"LastName" :bundle];
    dobTxtField.text=[Util convertDateFormat: [self getValue:@"Date_Of_Birth" :bundle]];
    phoneNo1TxtField.text= [self getValue:@"PhoneNumber1" :bundle];
    genderTxtField.text=[bundle objectForKey:@"Sex"];
    ageTxtField.text= [self getValue:@"Age" :bundle];
    emergencyContactTxtField.text=[self getValue:@"PhoneNumber2" :bundle];
    emergencyContactPhoneNoTxtField.text=[self getValue:@"Emergency_Contact_Num" :bundle]; 
    address1TxtField.text= [self getValue:@"Address1" :bundle]; 
    address2TxtField.text= [self getValue:@"Address2" :bundle];
    cityTxtField.text=[self getValue:@"City" :bundle];
    stateTxtField.text=[self getValue:@"State" :bundle];
    zipTxtField.text=[self getValue:@"Zip" :bundle];  
    emailIdTxtField.text=[self getValue:@"Email" :bundle];    
    patientAccNoTxtField.text= [self getValue:@"PatientAcctNum":bundle];
    hicnTxtField.text= [self getValue:@"HICN":bundle];
    practiseIdTxtField.text= [self getProviderName:[[self getValue:@"PracticeID":bundle] intValue]];
    insurance1IDTxtField.text = [self getValue:@"Insurance1ID":bundle];

}


-(id)getValue:(NSString*)key:(NSDictionary*)bundle{
      
    id value = [bundle objectForKey:key];
    if (value != nil && value != [NSNull null]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%d",[value intValue]];
        }
        return value;
    }
    return @""; 
}

-(NSString*)getProviderName:(int)_providerId{
      NSMutableArray *array = appDelegate.providersArray;
    for (int i = 0 , size = [array count]; i< size ; i++) {
        Provider *provider = [array objectAtIndex:i];
        if (provider.userId == _providerId) {
            selectedProvider = i;

            [providerIdPicker selectedRowInComponent:i];
            return provider.fullName;
        }
    }
    return @"";
}


- (void) createProgressionAlertWithMessage:(NSString *)message withActivity:(BOOL)activity
{
    if (progressAlert == nil) {
        progressAlert = [[UIAlertView alloc] initWithTitle: message
                                                   message: @"Please wait..."
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles: nil];
        
        // Create the progress bar and add it to the alert
        if (activity) {
            UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
            activityView.frame = CGRectMake(139.0f-18.0f, 80.0f, 37.0f, 37.0f);
            [progressAlert addSubview:activityView];
            [activityView startAnimating];
            [activityView release];
        } else {
            UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(30.0f, 80.0f, 225.0f, 90.0f)];
            [progressAlert addSubview:progressView];
            [progressView setProgressViewStyle: UIProgressViewStyleBar];
            [progressView release];
        }
    }
    [progressAlert show];
    [progressAlert release];
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

#pragma mark - Network delegate methods.

-(void)onSuccess:(id)result:(int)call{
    
    [self hideProgress];
    NSLog(@" Successfully got the data = %@ " ,result);
    
    switch (call) {
        case CALL_EDITPATIENT:
        case CALL_REGISTER:
        {
            
            NSString *message = fromEditCall ? @"Successfully updated patient info ." : @"Registered successfully ";
            [self showAlert:message : self];
            
         }
            
            break;
        case CALL_GETPATIENT:
            
            NSLog(@" response for getpatient %@  ",result);
            
            [self updatePatientInfo:result];
            
            break;
        
            
        default:
            break;
    }
    

    
//    NSLog(@"\n Result  from server is %@",result);
//    
//    NSString *responseString = [result objectForKey:@"result"];
//    NSLog(@"\nResult  from server is %@",responseString);
//    
//    if ([responseString isEqualToString:@"Success"])
//    {
//       
//        NSString *message = fromEditCall ? @"Successfully updated patient info .":@"Registered successfully ";
//        UIAlertView *resultAlert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        resultAlert.tag = 10;
//        [resultAlert show];
//        [resultAlert release];
//    }
    
}

-(void)onError:(NSString*)errorMsg:(int)call{
    [self hideProgress];
    NSLog(@"FAILED TO GET the data = %@ " ,errorMsg);
    
}

-(void)onConnectionTimeOut{
    
}



#pragma  mark - WebService call and  methods

-(NSMutableDictionary*)createRequestBuffer{
    
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    
    if (fromEditCall==YES)
    {
        //bundle
        
        Provider *provider = [[appDelegate providersArray] objectAtIndex:selectedProvider];
        
        [bundle setObject:firstNameTxtField.text forKey:@"FirstName"];
        [bundle setObject:middleNameTxtField.text forKey:@"MiddleName"];
        [bundle setObject:lastNameTxtField.text forKey:@"LastName"];
        [bundle setObject:[NSNumber numberWithInt:provider.practiceId] forKey:@"PracticeID"];
        [bundle setObject: [NSNumber numberWithInt:[patientAccNoTxtField.text intValue]]  forKey:@"PatientAcctNum"];   
        [bundle setObject:dobTxtField.text forKey:@"Date_Of_Birth"];
        [bundle setObject:[NSNumber numberWithInt:[phoneNo1TxtField.text intValue]] forKey:@"PhoneNumber1"];
        [bundle setObject:[NSNumber numberWithInt:[emergencyContactTxtField.text intValue]] forKey:@"PhoneNumber2"];
        
        [bundle setObject:genderTxtField.text forKey:@"Sex"];
        [bundle setObject:[NSNumber numberWithInt:[emergencyContactPhoneNoTxtField.text intValue]]forKey:@"Emergency_Contact_Num"];
        [bundle setObject:[NSNumber numberWithInt:[ageTxtField.text intValue]] forKey:@"Age"];
        [bundle setObject:emailIdTxtField.text forKey:@"Email"];
        [bundle setObject:address1TxtField.text forKey:@"Address1"];
        [bundle setObject:address2TxtField.text forKey:@"Address2"];
        [bundle setObject:cityTxtField.text forKey:@"City"];
        [bundle setObject:stateTxtField.text forKey:@"State"];
        [bundle setObject:zipTxtField.text forKey:@"Zip"];
        [bundle setObject:[NSNumber numberWithInt:[hicnTxtField.text intValue]] forKey:@"HICN"];
        [bundle setObject:[NSNumber numberWithInt:[insurance1IDTxtField.text intValue]] forKey:@"Insurance1ID"];  
        [bundle setObject:[NSNumber numberWithInt:provider.statusId] forKey:@"StatusID"];
        [bundle setObject:[NSNumber numberWithInt:provider.userId] forKey:@"ProviderID"];
 
    }
    else
    {
        if (selectedProvider == -1) {
            return nil; 
        }
        
        Provider *provider = [[appDelegate providersArray] objectAtIndex:selectedProvider];
             
        [bundle setObject:firstNameTxtField.text forKey:@"FirstName"];
        [bundle setObject:middleNameTxtField.text forKey:@"MiddleName"];
        [bundle setObject:lastNameTxtField.text forKey:@"LastName"];
        [bundle setObject:[NSNumber numberWithInt:provider.practiceId] forKey:@"PracticeID"];
        [bundle setObject: [NSNumber numberWithInt:[patientAccNoTxtField.text intValue]]  forKey:@"PatientAcctNum"];   
        [bundle setObject:dobTxtField.text forKey:@"Date_Of_Birth"];
        [bundle setObject:[NSNumber numberWithInt:[phoneNo1TxtField.text intValue]] forKey:@"PhoneNumber1"];
         [bundle setObject:[NSNumber numberWithInt:[emergencyContactTxtField.text intValue]] forKey:@"PhoneNumber2"];
        
        [bundle setObject:genderTxtField.text forKey:@"Sex"];
        [bundle setObject:[NSNumber numberWithInt:[emergencyContactPhoneNoTxtField.text intValue]]forKey:@"Emergency_Contact_Num"];
        [bundle setObject:[NSNumber numberWithInt:[ageTxtField.text intValue]] forKey:@"Age"];
        [bundle setObject:emailIdTxtField.text forKey:@"Email"];
        [bundle setObject:address1TxtField.text forKey:@"Address1"];
        [bundle setObject:address2TxtField.text forKey:@"Address2"];
        [bundle setObject:cityTxtField.text forKey:@"City"];
        [bundle setObject:stateTxtField.text forKey:@"State"];
        [bundle setObject:zipTxtField.text forKey:@"Zip"];
        [bundle setObject:[NSNumber numberWithInt:[hicnTxtField.text intValue]] forKey:@"HICN"];
        [bundle setObject:[NSNumber numberWithInt:[insurance1IDTxtField.text intValue]] forKey:@"Insurance1ID"];  
        [bundle setObject:[NSNumber numberWithInt:provider.statusId] forKey:@"StatusID"];
        [bundle setObject:[NSNumber numberWithInt:provider.userId] forKey:@"ProviderID"];

        
    }
  
    return bundle;
        
}

-(void)registerPatient:(NSMutableDictionary*)bundle{
    
    [self showProgress:@"Registering patient.."];
    MedTecNetwork *medtecNetwork = [MedTecNetwork shareInstance];
    [medtecNetwork registerPatients:bundle :self];
    return;
           
}

-(void)editPatient:(NSMutableDictionary*)bundle{
    [self showProgress:@"Updating .."];
    MedTecNetwork *medtecNetwork = [MedTecNetwork shareInstance];
    [medtecNetwork registerPatients:bundle :self];
    return;
}

-(void)getPatient:(NSMutableDictionary*)bundle{
    [self showProgress:@"loading.."];
     MedTecNetwork *medtecNetwork = [MedTecNetwork shareInstance];
    [medtecNetwork getPatientInfo:bundle :self];
    return;
}

#pragma mark - AlertView Delegate view

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 10){
        if(buttonIndex == 0){
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}


-(NSString*)validate{
        
    BOOL isValidate = YES;
    NSString *invalidField = nil;
    
        if([patientAccNoTxtField.text isEqualToString:@""])
        {
            isValidate = NO;
            invalidField = @"patient Account No";
        }else  if([firstNameTxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"first name";
        }else  if([lastNameTxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"last name";
        }else  if([phoneNo1TxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"phone no";
        }else  if([ageTxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"age";
        }else  if([genderTxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"gender";
        }else  if([address1TxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"address";
        }else  if([cityTxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"city";
        }else  if([stateTxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"state";
        }else  if([zipTxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"zip";
        }else  if([dobTxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"date of birth";
        }else  if([insurance1IDTxtField.text isEqualToString:@""]){
              isValidate = NO;
            invalidField = @"insurance id";
        } else  if([hicnTxtField.text isEqualToString:@""]){
            isValidate = NO;
            invalidField = @"hicn";
        }  
    
  
    return invalidField;
}

-(void) showAlert:(NSString*)message:(id<UIAlertViewDelegate>)delegate{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    if(delegate!=nil)
    alertView.tag = 10;
    
    [alertView show];
    [alertView release];
}

#pragma mark - POPUP view

-(void)popView:(int)value :(NSString *)name
{
    
    NSArray *a = [popView subviews];
    if([a count])
        for(int i=0;i<[a count];i++)
            [[a objectAtIndex:i]removeFromSuperview];
    [self.view addSubview:popView];
   
    if(storeTextField == dobTxtField)
    {
        [popView addSubview:datePicker];
        datePicker.frame = CGRectMake(402, 0, datePicker.frame.size.width, datePicker.frame.size.height);
    }
    if(storeTextField == genderTxtField)
    {
        [popView addSubview:genderPicker];
        genderPicker.frame = CGRectMake(402, 0, genderPicker.frame.size.width, genderPicker.frame.size.height);
    }
    if(storeTextField == practiseIdTxtField)
    {
        [popView addSubview:providerIdPicker];
        providerIdPicker.frame = CGRectMake(402, 0, providerIdPicker.frame.size.width, providerIdPicker.frame.size.height);
    }
    
    popView.frame =  CGRectMake(0, 2000, popView.frame.size.width, popView.frame.size.height);
    CGRect viewFrame = CGRectMake(0, value, popView.frame.size.width, popView.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[popView setFrame:viewFrame];
	[UIView commitAnimations];
    [self.view bringSubviewToFront:popView];
    
    
}

#pragma mark - UIBar Buttons Actions

- (IBAction) nextTextField
{
	NSInteger nextTag = [storeTextField tag] + 1;
   // NSLog(@"next tag : %d",nextTag);
	UIResponder* nextResponder = [storeTextField.superview viewWithTag:nextTag];
	if((nextResponder == dobTxtField) || (nextResponder == genderTxtField))
    {
        storeTextField = (UITextField *)nextResponder;// dobTxtField;
        nextResponder = [storeTextField.superview viewWithTag:nextTag-1];
        [nextResponder resignFirstResponder];
       // [self addDatePicker:450];
        [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];
    }
    else
    {
        [popView removeFromSuperview];
        [nextResponder becomeFirstResponder];
    }
	
}
- (IBAction) prevTextField
{
	
    NSInteger prevTag = [storeTextField tag] - 1;
     NSLog(@"prevTag tag : %d",prevTag);
	UIResponder* nextResponder = [storeTextField.superview viewWithTag:prevTag];
    if((nextResponder == dobTxtField) || (nextResponder == genderTxtField)) 
    {
        storeTextField= (UITextField *)nextResponder;// dobTxtField;
        nextResponder = [storeTextField.superview viewWithTag:prevTag+1];
        [nextResponder resignFirstResponder];
        // [self addDatePicker:450];
        [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];
    }
    else
    {
        [popView removeFromSuperview];
        [nextResponder becomeFirstResponder];
    }
	
}

-(void)keyBoardToolBaranimation:(int)value
{
    CGRect viewFrame = CGRectMake(0, value, keyBoardToolBar.frame.size.width, keyBoardToolBar.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[keyBoardToolBar setFrame:viewFrame];
	[UIView commitAnimations];
    [self.view bringSubviewToFront:keyBoardToolBar];
}

-(void)scrollViewAnimation:(int)value
{
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	bgScrollView.contentOffset = CGPointMake(0, value);
	[UIView commitAnimations];
}


#pragma mark - DOB selected method

-(IBAction)dobSelectedAction:(id)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setDateFormat:@"MM/dd/YYYY"];
   	NSString *selected = [dateFormatter stringFromDate:[datePicker date]];
    [dateFormatter release];    
	dobTxtField.text = selected;

}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	
        return 1;
   
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(pickerView.tag == 10)
        genderTxtField.text = [genderArray objectAtIndex:row];
    
    else if(pickerView.tag == 20)
    {
        
        Provider *provider =  [appDelegate.providersArray objectAtIndex:row];
        
        practiseIdTxtField.text = provider.fullName;
        selectedProvider = row;

    }
    else if(pickerView.tag==30)
    {        
        relationShip.text=[relationPickerArray objectAtIndex:row];
    }
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	if(pickerView.tag == 10)
        return [genderArray count];
    else if(pickerView.tag == 20)
        return [appDelegate.providersArray count];
    else if(pickerView.tag==30)
        return [relationPickerArray count];
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if(pickerView.tag == 10)
        return [genderArray objectAtIndex:row];
    else if(pickerView.tag == 20){
       Provider *provider =  [appDelegate.providersArray objectAtIndex:row];
        return provider.fullName;    
    }
    else if(pickerView.tag == 30)
        return [relationPickerArray objectAtIndex:row];
    return @"";
}

#pragma mark - TextField resign methods

-(void)textFieldsResignMethods
{
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    storeTextField = textField;
    
     
    if((textField == practiseIdTxtField) || (textField == dobTxtField) || (textField == genderTxtField))
    {
        [textField resignFirstResponder]; 
 
        [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];

    }
    else if((textField==insurance1IDTxtField)||(textField==subscriberName))
    {
        [popView removeFromSuperview];
        [self keyBoardToolBaranimation:4000];
    }
    else if(textField==relationShip)
    {
        
        [textField resignFirstResponder]; 
        relationPicker.frame = CGRectMake(402, 0, relationPicker.frame.size.width, relationPicker.frame.size.height);
        
        popView.frame =  CGRectMake(0, 2000, popView.frame.size.width, popView.frame.size.height);
        CGRect viewFrame = CGRectMake(0, 490, popView.frame.size.width, popView.frame.size.height);
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration: 0.3];
        [popView setFrame:viewFrame];
        [UIView commitAnimations];
        [self.view bringSubviewToFront:popView];
        [self.view addSubview:popView];
        [popView addSubview:relationPicker];
        
        /////Commented
        //[self popView:490 :nil];       
        [self keyBoardToolBaranimation:4000];
    }
    else
    {
        [popView removeFromSuperview];
        [self keyBoardToolBaranimation:310];
    }

    [self setAnimationToScrollView];

        
//    if((textField==ageTxtField)||(textField==sub1IDTxtField)||(textField==sub2IDTxtField) ||(textField==sub3IDTxtField)||(textField==heightTxtField)||(textField==weightTxtField)||(textField==guarantor1IDTxtField)||(textField==guarantor2IDTxtField)||(textField==guarantor3IDTxtField)||(textField==phoneNo1TxtField)||(textField==phoneNo2TxtField))
//        textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
        if((textField==ageTxtField)||(textField==phoneNo1TxtField)||(textField==emergencyContactTxtField)||(textField==zipTxtField))
           textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==dobTxtField) 
    {
        storeTextField=dobTxtField;
        [lastNameTxtField resignFirstResponder];
        [emergencyContactTxtField resignFirstResponder];
        [practiseIdTxtField resignFirstResponder];
        [patientAccNoTxtField resignFirstResponder];
        [firstNameTxtField resignFirstResponder];
        [middleNameTxtField resignFirstResponder];
        [emailIdTxtField resignFirstResponder];
        [phoneNo1TxtField resignFirstResponder];
        [emergencyContactPhoneNoTxtField resignFirstResponder];
        //[phoneNo2TxtField resignFirstResponder];
        [ageTxtField resignFirstResponder];
        [genderTxtField resignFirstResponder];
        [address1TxtField resignFirstResponder];
        [address2TxtField resignFirstResponder];
        [cityTxtField resignFirstResponder];
        [stateTxtField resignFirstResponder];
        [zipTxtField resignFirstResponder];
        [hicnTxtField resignFirstResponder];
        [insurance1IDTxtField resignFirstResponder];
 
        [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];
        return NO;
    }
   else if (textField==genderTxtField) 
    {
        storeTextField=genderTxtField;
        [lastNameTxtField resignFirstResponder];
        [emergencyContactTxtField resignFirstResponder];
        [practiseIdTxtField resignFirstResponder];
        [patientAccNoTxtField resignFirstResponder];
        [firstNameTxtField resignFirstResponder];
        [middleNameTxtField resignFirstResponder];
        [emailIdTxtField resignFirstResponder];
        [phoneNo1TxtField resignFirstResponder];
        //[phoneNo2TxtField resignFirstResponder];
        [ageTxtField resignFirstResponder];
        [address1TxtField resignFirstResponder];
        [address2TxtField resignFirstResponder];
        [cityTxtField resignFirstResponder];
        [stateTxtField resignFirstResponder];
        [zipTxtField resignFirstResponder];
        [insurance1IDTxtField resignFirstResponder];
        [hicnTxtField resignFirstResponder];
        [dobTxtField resignFirstResponder];
        [emergencyContactPhoneNoTxtField resignFirstResponder];

        [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];
        return NO;
    }
    if (textField==practiseIdTxtField) 
    {
        storeTextField=practiseIdTxtField;
        [lastNameTxtField resignFirstResponder];
        [emergencyContactTxtField resignFirstResponder];
        [patientAccNoTxtField resignFirstResponder];
        [firstNameTxtField resignFirstResponder];
        [middleNameTxtField resignFirstResponder];
        [emailIdTxtField resignFirstResponder];
        [phoneNo1TxtField resignFirstResponder];
        //[phoneNo2TxtField resignFirstResponder];
        [ageTxtField resignFirstResponder];
        [address1TxtField resignFirstResponder];
        [address2TxtField resignFirstResponder];
        [cityTxtField resignFirstResponder];
        [stateTxtField resignFirstResponder];
        [zipTxtField resignFirstResponder];
        [insurance1IDTxtField resignFirstResponder];

         [self popView:490 :nil];
        [self keyBoardToolBaranimation:446];
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self keyBoardToolBaranimation:4000];
    [textField resignFirstResponder];
    return YES;
}

-(void)setAnimationToScrollView
{
   /* if( (storeTextField.tag > 0)&& (storeTextField.tag <= 12))
        [self scrollViewAnimation:0];
    else if((storeTextField.tag > 12) && (storeTextField.tag < 16))
        [self scrollViewAnimation:50];
    else if((storeTextField.tag >= 16) && (storeTextField.tag < 19))
        [self scrollViewAnimation:90];
    else if((storeTextField.tag >= 19) && (storeTextField.tag < 22))
        [self scrollViewAnimation:140];
    else if((storeTextField.tag >= 22) && (storeTextField.tag < 25))
        [self scrollViewAnimation:200];
    else if((storeTextField.tag >= 25) && (storeTextField.tag < 28))
        [self scrollViewAnimation:240];
    else if((storeTextField.tag >= 28) && (storeTextField.tag < 31))
        [self scrollViewAnimation:280];
    else if((storeTextField.tag >= 31) && (storeTextField.tag < 34))
        [self scrollViewAnimation:320];
    else if((storeTextField.tag >= 34) && (storeTextField.tag < 37))
        [self scrollViewAnimation:370];*/
         
        
        if( (storeTextField.tag > 0)&& (storeTextField.tag <= 8))
            [self scrollViewAnimation:0];
        else if((storeTextField.tag > 9) && (storeTextField.tag < 12))
            [self scrollViewAnimation:150];
        else if((storeTextField.tag >= 13) && (storeTextField.tag < 15))
            [self scrollViewAnimation:200];
        else if((storeTextField.tag >= 16) && (storeTextField.tag < 17))
            [self scrollViewAnimation:240];
        
        
        
   
    
    
}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField2 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
	if((textField2==ageTxtField)/*||(textField2==heightTxtField)||(textField2==weightTxtField)*/|| (textField2 ==phoneNo1TxtField)||/* (textField2==phoneNo2TxtField)||*/(textField2 ==emergencyContactTxtField) ||(textField2 ==zipTxtField)||(textField2 ==emergencyContactPhoneNoTxtField))
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
	
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self textFieldsResignMethods];
}

-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)signatureButonClicked
{
    
}
- (void)dealloc
{
    [practiceID release];
    [providerID release];
    [relationPickerArray release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    selectedProvider = 0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    practiceID=[[NSString alloc] init];
    providerID=[[NSString alloc] init];
    
    if (fromEditCall == YES && patientInfo != nil)
    {
        
        
        
        NSLog(@" EDIT PATIENT ");
        
        NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
        [bundle setObject:[ NSNumber numberWithInt: patientInfo.practiceId ]forKey:@"PracticeID"];
         [bundle setObject:[NSNumber numberWithInt:patientInfo.patientId] forKey:@"PatientID"];
        
        [self getPatient:bundle];
            
//        emergencyContactTxtField.text=[fromEditDict objectForKey:@"Emergency_Contact_Num"];
//        practiseIdTxtField.text= patientInfo.practiceId;
//        patientAccNoTxtField.text=[fromEditDict objectForKey:@"PatientAcctNum"];
//        firstNameTxtField.text= patientInfo.firstname;
//        middleNameTxtField.text=[fromEditDict objectForKey:@"MiddleName"];
        lastNameTxtField.text= patientInfo.lastname;
//        emailIdTxtField.text=[fromEditDict objectForKey:@"Email"];
        phoneNo1TxtField.text= [NSString stringWithFormat:@"%d",patientInfo.phoneNo];
        
    //phoneNo2TxtField.text=[fromEditDict objectForKey:@"PhoneNumber2"];
        
        NSString *tmpStr = [fromEditDict objectForKey:@"Age"];
       // NSLog(@"%@",tmpStr); 
        [tmpStr retain];
       // NSLog(@"%@",[fromEditDict objectForKey:@"Sub1ID"]);
        
//    ageTxtField.text=[[fromEditDict objectForKey:@"Age"] stringValue];
//    genderTxtField.text=[fromEditDict objectForKey:@"Sex"];
//    address1TxtField.text=[fromEditDict objectForKey:@"Address1"];
//    address2TxtField.text=[fromEditDict objectForKey:@"Address2"];
//    cityTxtField.text=[fromEditDict objectForKey:@"City"];
//    stateTxtField.text=[fromEditDict objectForKey:@"State"];
//    zipTxtField.text=[fromEditDict objectForKey:@"Zip"];
    dobTxtField.text= patientInfo.dob;
    /*insurance1IDTxtField.text=[fromEditDict objectForKey:@"Insurance1ID"];
    sub1IDTxtField.text=[[fromEditDict objectForKey:@"Sub1ID"] stringValue];
    sub1FirstNameTxtField.text=[fromEditDict objectForKey:@"Sub1FirstName"];
    sub1LastNameTxtField.text=[fromEditDict objectForKey:@"Sub1LastName"];
    insurance2IDTxtField.text=[fromEditDict objectForKey:@"Insurance2ID"] ;
    sub2IDTxtField.text=[[fromEditDict objectForKey:@"Sub2ID"] stringValue];
    sub2FirstNameTxtField.text=[fromEditDict objectForKey:@"Sub2FirstName"];
    sub2LastNameTxtField.text=[fromEditDict objectForKey:@"Sub2LastName"];
    insurance3IDTxtField.text=[fromEditDict objectForKey:@"Insurance3ID"] ;
    sub3IDTxtField.text=[[fromEditDict objectForKey:@"Sub3ID"] stringValue];
    sub3FirstNameTxtField.text=[fromEditDict objectForKey:@"Sub3FirstName"];
    sub3LastNameTxtField.text=[fromEditDict objectForKey:@"Sub3LastName"];
    hicnTxtField.text=[fromEditDict objectForKey:@"HICN"];
    heightTxtField.text=[[fromEditDict objectForKey:@"Height"] stringValue];
    weightTxtField.text=[[fromEditDict objectForKey:@"Weight"] stringValue];
    pTypeTxtField.text=[fromEditDict objectForKey:@"Ptype"];
    guarantor1IDTxtField.text=[[fromEditDict objectForKey:@"Guarantor1ID"] stringValue];
    guarantor2IDTxtField.text=[[fromEditDict objectForKey:@"Guarantor2ID"] stringValue];
    guarantor3IDTxtField.text=[[fromEditDict objectForKey:@"Guarantor3ID"] stringValue];*/
   // statusIDTxtField.text=[[fromEditDict objectForKey:@"StatusID"] stringValue];

    }
   
    
    
    registerRequestDict = [[NSMutableDictionary alloc] init];
    genderArray = [[NSArray alloc]initWithObjects:@"Male",@"Female",@"other", nil];
    
    [self performSelectorInBackground:@selector(getProviderIDS) withObject:nil];
    
    // Do any additional setup after loading the view from its nib.
   // NSLog(@"%s",__FUNCTION__);
    appDelegate = (Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    //self.navigationItem.hidesBackButton = YES;
   /* appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    demoGraphicsView = [[DemographicsView alloc] initWithFrame:CGRectMake(0, 50, 1024, 50)];
    
   /* appFooterView = [[AppFooterView alloc] initWithFrame:CGRectMake(0, 655, 1024, 50)];
    [appFooterView.signatureButton addTarget:self action:@selector(signatureButonClicked) forControlEvents:UIControlEventTouchUpInside]; 
    
    
    [self.view addSubview:demoGraphicsView];
    [self.view addSubview:appHeaderView];
    [self.view addSubview:appFooterView];*/
    
    [bgScrollView setContentSize:CGSizeMake(1000, 1000)];
    
//    doneButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 60, 100, 35)];
//    [doneButton setTitle:@"Done" forState:UIControlStateNormal];
//    doneButton.backgroundColor = [UIColor blackColor];
//    [doneButton addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:doneButton];
    
//    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonAction)];
//    self.navigationItem.rightBarButtonItem = rightB;
//    [rightB release];
    
//    UIBarButtonItem *rightBarButton=[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"save.png"]style:UIBarButtonItemStylePlain target:self action:@selector(doneButtonAction)];
//    self.navigationItem.rightBarButtonItem=rightBarButton;
//    [rightBarButton release];
    
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOutAction)];
    self.navigationItem.rightBarButtonItem = rightB;
    [rightB release];    
     
    activityIndicator =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(160, 240);
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
  /*  ////////// array alloc 
    
 keysArray = [[NSMutableArray alloc] initWithObjects:@"ProviderID",@"FirstName",@"MiddleName",@"LastName",@"PracticeID",@"PatientAcctNum",@"Date_Of_Birth",@"PhoneNumber1" ,@"PhoneNumber2",@"Sex",@"Emergency_Contact_Num",@"Age",@"Email",@"Address1",@"Address2",@"City",@"State",@"Zip",@"Sub1ID",@"Insurance1ID",@"Sub1FirstName",@"Sub1LastName",@"Sub2ID",@"Insurance2ID",@"Sub2FirstName",@"Sub2LastName",@"Insurance3ID",@"Sub3ID",@"Sub3FirstName",@"Sub3LastName",@"HICN",@"Height",@"Weight",@"Ptype",@"Guarantor1ID",@"Guarantor2ID",@"Guarantor3ID",@"StatusID",nil];//@"Driver_Licence_Img",
    
    //NSLog(@"%@",keysArray);

   tmpArray = [[NSMutableArray alloc] initWithObjects:@"1",@"ghgdgd",@"Viswanath",@"mallichetty",@"1",@"123",@"10/28/1977",@"9000687123",@"9000687124",@"M",@"9000687125",@"22",@"sai@gmail.com",@"alakapuri",@"road4444no19",@"hyd",@"ap",@"50004482",@"1dsafsf",@"11",@"satish",@"kumar",@"2",@"22",@"prateek",@"raj",@"33",@"3",@"chaitanya",@"kumar",@"12345",@"5",@"70",@"normal",@"111",@"222",@"333",@"1", nil];*/
    
 
     [registerRequestDict setObject:@"" forKey:@"ProviderID"];
     [registerRequestDict setObject:@"" forKey:@"FirstName"];
      [registerRequestDict setObject:@"" forKey:@"MiddleName"];
      [registerRequestDict setObject:@"" forKey:@"LastName"];
      [registerRequestDict setObject:@"" forKey:@"PracticeID"];
      [registerRequestDict setObject:@"" forKey:@"PatientAcctNum"];
      [registerRequestDict setObject:@"" forKey:@"Date_Of_Birth"];
      [registerRequestDict setObject:@"" forKey:@"PhoneNumber1"];
      [registerRequestDict setObject:@"" forKey:@"PhoneNumber2"];
      [registerRequestDict setObject:@"" forKey:@"Sex"];
      [registerRequestDict setObject:@"" forKey:@"Emergency_Contact_Num"];
      [registerRequestDict setObject:@"" forKey:@"Age"];
      [registerRequestDict setObject:@"" forKey:@"Email"];
      [registerRequestDict setObject:@"" forKey:@"Address1"];
      [registerRequestDict setObject:@"" forKey:@"Address2"];
      [registerRequestDict setObject:@"" forKey:@"City"];
      [registerRequestDict setObject:@"" forKey:@"State"];
      [registerRequestDict setObject:@"" forKey:@"Zip"];
      [registerRequestDict setObject:@"" forKey:@"Sub1ID"];
      [registerRequestDict setObject:@"" forKey:@"Insurance1ID"];
      [registerRequestDict setObject:@"" forKey:@"Sub1FirstName"];
      [registerRequestDict setObject:@"" forKey:@"Sub1LastName"];
      [registerRequestDict setObject:@"" forKey:@"Sub2ID"];
      [registerRequestDict setObject:@"" forKey:@"Insurance2ID"];
      [registerRequestDict setObject:@"" forKey:@"Sub2FirstName"];
      [registerRequestDict setObject:@"" forKey:@"Sub2LastName"];
      [registerRequestDict setObject:@"" forKey:@"Insurance3ID"];
      [registerRequestDict setObject:@"" forKey:@"Sub3ID"];
      [registerRequestDict setObject:@"" forKey:@"Sub3FirstName"];
      [registerRequestDict setObject:@"" forKey:@"Sub3LastName"];
      [registerRequestDict setObject:@"" forKey:@"HICN"];
      [registerRequestDict setObject:@"" forKey:@"Height"];
      [registerRequestDict setObject:@"" forKey:@"Weight"];
      [registerRequestDict setObject:@"" forKey:@"Ptype"];
      [registerRequestDict setObject:@"" forKey:@"Guarantor1ID"];
      [registerRequestDict setObject:@"" forKey:@"Guarantor2ID"];
      [registerRequestDict setObject:@"" forKey:@"Guarantor3ID"];
      [registerRequestDict setObject:@"" forKey:@"StatusID"];
    
    [self.view addSubview:keyBoardToolBar];
    keyBoardToolBar.center = CGPointMake(self.view.frame.size.width/2, 2000);
    
    [insuranceType_Self setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    [insuranceType_Dependent setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
    
    statusLabel.text=@"New";
    
   // NSLog(@"mail value is =%@",[tmpArray objectAtIndex:12]);
    
    insurance1IDTxtField.hidden=YES;
    insuranceIdLabel.hidden=YES;
    subscriberNameLabel.hidden=YES;
    subscriberName.hidden=YES;
    relationShip.hidden=YES;
    relationShipLabel.hidden=YES;
    relationPickerArray=[[NSMutableArray alloc] initWithCapacity:0];
    [relationPickerArray addObject:@"Spouce"];
    [relationPickerArray addObject:@"Child"];
    [relationPickerArray addObject:@"Others"];
    
//    patientAccNoTxtField.text=@"111";
//    firstNameTxtField.text=@"Logic";
//    lastNameTxtField.text=@"Test";
//    phoneNo1TxtField.text=@"11111111111";
//    ageTxtField.text=@"50";
//    genderTxtField.text=@"Male";
//    address1TxtField.text=@"Banjara Hills";
//    cityTxtField.text=@"Hyderabad";
//    stateTxtField.text=@"Andhra Pradesh";
//    zipTxtField.text=@"522001";
//    dobTxtField.text=@"08/08/1975";
//    insurance1IDTxtField.text=@"132";
//    hicnTxtField.text=@"2";
           
    
}

-(void)logOutAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)insuranceTypeForSelf:(id)sender
{
        isSelf=YES;
        [insuranceType_Self setImage:[UIImage imageNamed:@"CheckBoxHL.png"] forState:UIControlStateNormal];
        [insuranceType_Dependent setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        //[insuranceType_Self addTarget:self action:@selector(adjustUIForInsurance) forControlEvents:UIControlEventTouchUpInside];
    
        insurance1IDTxtField.hidden=NO;
        insuranceIdLabel.hidden=NO;
        subscriberNameLabel.hidden=YES;
        subscriberName.hidden=YES;
        relationShip.hidden=YES;
        relationShipLabel.hidden=YES;
        
       
}
-(IBAction)insuranceTypeForDependent:(id)sender
{
        isDependent=YES;
        [insuranceType_Dependent setImage:[UIImage imageNamed:@"CheckBoxHL.png"] forState:UIControlStateNormal];
        [insuranceType_Self setImage:[UIImage imageNamed:@"checkBox.png"] forState:UIControlStateNormal];
        //[insuranceType_Dependent addTarget:self action:@selector(adjustUIForInsurance) forControlEvents:UIControlEventTouchUpInside];
    
        insurance1IDTxtField.hidden=NO;
        insuranceIdLabel.hidden=NO;
        subscriberNameLabel.hidden=NO;
        subscriberName.hidden=NO;
        relationShip.hidden=NO;
        relationShipLabel.hidden=NO;  

}



- (void)keyboardWillHide:(NSNotification *)notification
{
    [self keyBoardToolBaranimation:4000];    
    
}

-(void)getProviderIDS
{
    
    NSAutoreleasePool *pool=[[NSAutoreleasePool alloc] init];
    
    NSMutableArray *providersArray = appDelegate.providersArray;

    if( providersArray != nil || [providersArray count] == 0){
  
        GetProviderIDs *gData = [GetProviderIDs sharedDataSource];
        [gData providerIdsMethod];
        
    }
    [pool drain];
   
}


-(IBAction)drivingLicenseImage:(id)sender
{
    
  	UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
															 delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil
													otherButtonTitles:@"Photo Library",@" Use Camera",@"Cancel", nil];
	
	actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
	actionSheet.destructiveButtonIndex = 2;	
	[actionSheet showInView:self.view]; 
	[actionSheet release];    
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	   
    if (buttonIndex == 0)
    {
        [self pickImageFromPhotoLibrary];        
    }
       
    else if(buttonIndex==1)
    {        
        [self pickImageFromCamera];	  				
        
    }
    else if(buttonIndex==2){      

        [actionSheet dismissWithClickedButtonIndex:2 animated:NO];			
    }		
    
}



- (void)pickImageFromPhotoLibrary {
	
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate =self;
	imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { 
		Class popoverClass = (NSClassFromString(@"UIPopoverController"));
		if (popoverClass != nil) {
			// you're on ipad
			
			popover = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
			[popover presentPopoverFromRect:CGRectMake(100, 100.0, 0.0, 0.0) 
									 inView:self.navigationController.view
				   permittedArrowDirections:UIPopoverArrowDirectionAny 
								   animated:YES];
			
			//[popover dismissPopoverAnimated:YES];
			
		}
	}
	else {
		// you're on iphone/ipod touch
		[self.navigationController presentModalViewController:imagePicker animated:NO];
	}
	
	
	[imagePicker release];
}


- (void)pickImageFromCamera {	

    UIImagePickerController *imagePickerFromCamera = [[UIImagePickerController alloc] init];
	imagePickerFromCamera.delegate =self;
	imagePickerFromCamera.sourceType = UIImagePickerControllerSourceTypeCamera;
	[self.navigationController presentModalViewController:imagePickerFromCamera animated:NO];
	[imagePickerFromCamera release];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	
	[self.navigationController dismissModalViewControllerAnimated:YES];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) { 
		
		Class popoverClass = (NSClassFromString(@"UIPopoverController"));
		if (popoverClass != nil) {
			// you're on ipad
			[popover dismissPopoverAnimated:YES];
		} 
	}

	// Get the image from the result
	UIImage *image=[[info valueForKey:@"UIImagePickerControllerOriginalImage"]retain];
	[drivingLicenseButton setImage:image forState:UIControlStateNormal];
	
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
