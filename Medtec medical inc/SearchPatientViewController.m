//
//  SearchPatientViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SearchPatientViewController.h"
#import "MainViewController.h"
#import "SearchPatientTableViewCell.h"
#import "SearchPatientDetailsViewController.h"
#import "AppHeaderView.h"
#import "TdCalendarView.h"
#import "Medtec_medical_incAppDelegate.h"
#import "RegisterPatientViewController.h"
#import "JSON.h"
#import "NewEncountersViewController.h"
#import "Provider.h"
#import "MedTecNetwork.h"
#import "GetProviderIDs.h"
#import "PatientInfo.h"

@interface SearchPatientViewController()

-(void)updateTable:(NSMutableArray*)array;
-(void)showAlert:(NSString*)message;
-(NSMutableDictionary*)createRequestBundle;
-(void)showProgress :(NSString*)message;
-(void)hideProgress;

@end


@implementation SearchPatientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(IBAction)searchButton:(id)sender
{
    NSLog(@"SEARCH BUTTON PRESSED");
   
    if(([selectProviderTxt.text length] == 0) && ([insurenceIdTxt.text length] == 0) && ([firstNameTxt.text length] == 0)  && ([lastNameTxt.text length] == 0) && ([dobTxt.text length] == 0)&& ([phoneTxt.text length] == 0) && ([date1Txt.text length] == 0)&& ([date2Txt.text length] == 0))
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Enter atleast one field" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
 
    
}
-(IBAction)calenderButtonClicked:(UIButton *)sender
{

}


-(IBAction)newPatientButtonClicked:(UIButton *)sender

{
    RegisterPatientViewController *registerPatient  = [[RegisterPatientViewController alloc] init];
    [self.navigationController pushViewController:registerPatient animated:YES];
    [registerPatient release];
    
    
}
-(IBAction)alertsButtonClicked:(UIButton *)sender
{
    
}
-(IBAction)homeButtonClicked:(UIButton *)sender
{
    if (mainViewController != nil)
    {
        [mainViewController release];
    }
    mainViewController = [[MainViewController alloc] init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	
    return 1;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
        providerPickerIndex = row;
        pickerView.tag = row;
    
        
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
        return [appDelegate.providersArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    Provider *provider = [appDelegate.providersArray objectAtIndex:row];
    return provider.fullName;
}


#pragma mark -  Pop View

-(IBAction)toolBar_cancelAction:(id)sender
{
    [self popView:2000];
}
-(IBAction)toolBar_saveAction:(id)sender
{
    if(storeTextField == dobTxt)
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"MM/dd/YYYY"];
        NSString *selected = [dateFormatter stringFromDate:[dobPicker date]];
        dobTxt.text = selected;
    }
    else
    {
//       selectProviderTxt.text = [NSString stringWithFormat:@"%@",[[providersID_array objectAtIndex:providerPickerIndex]objectForKey:@"PracticeID"]];
          
        Provider *provider = [appDelegate.providersArray objectAtIndex:providerPickerIndex];
        selectProviderTxt.text = provider.fullName;
      
    }
    
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
    
    if((storeTextField == date1Txt) || (storeTextField == date2Txt))
    {
        
        [popupView addSubview:tdView];
        tdView.frame = CGRectMake(402, 0, tdView.frame.size.width, tdView.frame.size.height);
    }
    if(storeTextField == dobTxt)
    {
        [popupView addSubview:dobToolBar];
        dobToolBar.frame = CGRectMake(402, 0, dobToolBar.frame.size.width, dobToolBar.frame.size.height);
        
        [popupView addSubview:dobPicker];
        dobPicker.frame = CGRectMake(402, dobToolBar.frame.size.height+dobToolBar.frame.origin.y, dobPicker.frame.size.width, dobPicker.frame.size.height);
    }
    
    if(storeTextField == selectProviderTxt)
    {
        [popupView addSubview:dobToolBar];
        dobToolBar.frame = CGRectMake(402, 0, dobToolBar.frame.size.width, dobToolBar.frame.size.height);
        
        [popupView addSubview:providersPicker];
        providersPicker.frame = CGRectMake(402, dobToolBar.frame.size.height+dobToolBar.frame.origin.y, providersPicker.frame.size.width, providersPicker.frame.size.height);
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

-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Equipment Actions

-(IBAction)equType_action:(id)sender
{
    if([sender tag] == 100)
    {
        if(!isRentSelected)
        {
            isRentSelected = !isRentSelected;
            isBuySelected = NO;
            equTypeString = @"rent";
            [rentButton setBackgroundImage:[UIImage imageNamed:@"CheckBoxHL.png"] forState:UIControlStateNormal];
            [buyButton setBackgroundImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            isRentSelected = !isRentSelected;
            equTypeString = @"";
            [rentButton setBackgroundImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        if(!isBuySelected)
        {
            isBuySelected = !isBuySelected;
            isRentSelected = NO;
            equTypeString = @"buy";
            [buyButton setBackgroundImage:[UIImage imageNamed:@"CheckBoxHL.png"] forState:UIControlStateNormal];
            [rentButton setBackgroundImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            isBuySelected = !isBuySelected;
            equTypeString = @"";
            [buyButton setBackgroundImage:[UIImage imageNamed:@"CheckBox.png"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark - TextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    storeTextField = textField;
     if((textField == dobTxt) || (textField == date1Txt) || (textField == date2Txt) || (textField == selectProviderTxt)) 
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
    previousTxtField = textField;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
     storeTextField = textField;
    if((textField == dobTxt) || (textField == date1Txt) || (textField == date2Txt) || (textField == selectProviderTxt)) 
    {
        [insurenceIdTxt resignFirstResponder];
        [firstNameTxt resignFirstResponder];
        [lastNameTxt resignFirstResponder];
        [phoneTxt resignFirstResponder];
       
        [equipmentNameTxt resignFirstResponder];
        [self popView:400];
        return NO;
    }
    else
    {
         [self popView:2000];
    }
    return YES;
}


- (BOOL)textField:(UITextField *)textField2 shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
	if(textField2==phoneTxt){
		BOOL isNumeric=FALSE;
		if ([string length] == 0) 
		{
			isNumeric=TRUE;
		}
		else
		{
			
			if ( [string compare:[NSString stringWithFormat:@"%d",0]]==0 || [string compare:[NSString stringWithFormat:@"%d",1]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",2]]==0 || [string compare:[NSString stringWithFormat:@"%d",3]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",4]]==0 || [string compare:[NSString stringWithFormat:@"%d",5]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",6]]==0 || [string compare:[NSString stringWithFormat:@"%d",7]]==0
				|| [string compare:[NSString stringWithFormat:@"%d",8]]==0 || [string compare:[NSString stringWithFormat:@"%d",9]]==0)
			{
				isNumeric=TRUE;
			}
		}
		
		
		return isNumeric;
    }
	
	
	return YES;
	
}

#pragma mark -seach , validate , create buffer methods

-(IBAction)searchPatients
{
        
    [self showProgress:@"Searching .."];
    MedTecNetwork *medtecNetwork =  [MedTecNetwork shareInstance];
//  [medtecNetwork searchPatients:[self createRequestBundle] :self];
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
//  [bundle setObject: [NSNumber numberWithInt:7] forKey:@"EncounterID"];
    [bundle setObject: [NSNumber numberWithInt:18] forKey:@"PatientID"];    
    [medtecNetwork getPatientAllEncounters:bundle:self];
    
}

-(NSMutableDictionary*)createRequestBundle{
    
 
//    Public    int    EncounterID { get; set; }
//    public    int     PracticeID { get; set; }
//    public    int     PatientID { get; set; }
//    public   string   FirstName{ get; set; }
//    public   string    LastName{ get; set; }
//    public   string    PhoneNumber1{ get; set; }
//    public    DateTime Date_Of_Birth{ get; set; }
//    public   string    Manufacturer{ get; set; }
//    public   string    Insurance1ID{ get; set; }
//    public   DateTime Date { get; set; }
//    public   string       Equip_Options{ get; set; }
//    public   string       Equip_Name { get; set; }
//    public   DateTime FromDate { get; set; }
//    public   DateTime ToDate { get; set; }
    
    
     NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    if (appDelegate.providersArray != nil && [appDelegate.providersArray count] > 0) {
        Provider *provider = [appDelegate.providersArray objectAtIndex:providersPicker.tag];
        [bundle setObject:[NSNumber numberWithInt:provider.practiceId] forKey:@"PracticeID"];
    }
    
    if (![firstNameTxt.text isEqualToString:@""]) {
        [bundle setObject:firstNameTxt.text forKey:@"FirstName"];
    }
    
    if (![lastNameTxt.text isEqualToString:@""]) {
        [bundle setObject:firstNameTxt.text forKey:@"LastName"];
    }
    
    if (![phoneTxt.text isEqualToString:@""]) {
        [bundle setObject:phoneTxt.text forKey:@"PhoneNumber1"];
    }
    
    if (![dobTxt.text isEqualToString:@""]) {
        [bundle setObject:dobTxt.text forKey:@"FirstName"];
    }
    
    if (![insurenceIdTxt.text isEqualToString:@""]) {
        [bundle setObject:insurenceIdTxt.text forKey:@"Insurance1ID"];
    }
    
    if (![date1Txt.text isEqualToString:@""]) {
        [bundle setObject:date1Txt.text forKey:@"FromDate"];
    }
    
    if (![date2Txt.text isEqualToString:@""]) {
        [bundle setObject:date2Txt.text forKey:@"ToDate"];
    }
       
    return bundle;
    
}

#pragma mark - show/hide progress alert 

-(void)showProgress :(NSString*)message
{      
    
    if (progressAlert == nil) {
        progressAlert = [[UIAlertView alloc] initWithTitle: @"" message: message delegate: nil cancelButtonTitle: nil otherButtonTitles: nil];
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectMake(40.0f, 20.0f, 37.0f, 37.0f);
        [progressAlert addSubview:activityView];
        [activityView startAnimating];
        [activityView release];
        
    }
    
    [progressAlert show];
}

-(void)hideProgress
{    
    if (progressAlert != nil)
	{
    [progressAlert dismissWithClickedButtonIndex:0 animated:YES];
    }  
}


#pragma mark - network delegate methods

-(void)onSuccess:(id)result:(int)call{
    
    [self hideProgress];
    
    BOOL test = YES;
    
    NSLog(@" SUCCESSFULLY GOT DATA  - %@ ",result);
    NSArray *arrayBundle = nil;
    
    if ([result isKindOfClass:[NSArray class]]) {
        arrayBundle = result;
    }else if([result isKindOfClass:[NSDictionary class]]){
      arrayBundle  = [[NSArray alloc]initWithObjects:result, nil];
    }
    
//    if ( test != YES || arrayBundle == nil || [arrayBundle count] == 0 ) {
//        // show no patient Info alert
//        [self showAlert:@"No patient Info found"];
//        return;
//    }
//   
    if (patientInfoArray != nil) {
        [patientInfoArray release];
        patientInfoArray = nil;
    }
        
     patientInfoArray = [[NSMutableArray alloc]init];
     [patientInfoArray addObject:[PatientInfo testPatientInfo]];
     for (NSDictionary *patientBundle in arrayBundle) {
        PatientInfo *info = [[PatientInfo alloc]initWithBundle:patientBundle];
        [patientInfoArray addObject:[info retain]];
         NSLog(@" Patient info name %@ ",info.firstname);
//        [info release];
    }
    
    [self updateTable:patientInfoArray];

}

-(void)onError:(NSString*)errorMsg:(int)call{
    
    [self hideProgress];
    NSLog(@" FAILED TO GET  DATA  - %@ ",errorMsg);

    
}

-(void)onConnectionTimeOut{
    
    [self hideProgress];
    
    NSLog(@"CONNECTION TIME OUT  - ");

}

#pragma mark - show Alert methd

-(void)showAlert:(NSString*)message{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
    [alert release];
    
}

-(void)updateTable:(NSMutableArray*)patientInfoArray{
    [searchPatientTableView reloadData];
}


#pragma mark -Table view delegate methods


//////////// Table view data source and delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [patientInfoArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *customCellIdentifier =@"CustomCellIdentifier";
    //NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
    SearchPatientTableViewCell *cell=(SearchPatientTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
    if (cell==nil) 
    {          
        NSArray *topObject=[[NSBundle mainBundle] loadNibNamed:@"SearchPatientTableViewCell" owner:nil options:nil];
            for (id object in topObject) 
            {
                if ([object isKindOfClass:[SearchPatientTableViewCell class]]) {
                    cell =(SearchPatientTableViewCell *)object;
                }
            }						
        }
    if (cell != nil) {
        cell.searchViewController = self;
        PatientInfo *_patientInfo = [[patientInfoArray objectAtIndex:indexPath.row]retain];
        
        NSLog(@" PAtient info name at %d - %@ ",indexPath.row , _patientInfo.firstname);
        cell.patientInfo  = _patientInfo ;
        [cell loadData:_patientInfo];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    curOption=1;
//    SearchPatientDetailsViewController *spdViewController = [[SearchPatientDetailsViewController alloc] init];
//    spdViewController.selecteddictionary = [allPatientsInfoArry objectAtIndex:indexPath.row];
//    [self.navigationController pushViewController:spdViewController animated:YES];
    
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
-(void)newEncounter:(id)sender:(PatientInfo*)info
{
    NewEncountersViewController *newEncountersViewController = [[NewEncountersViewController alloc] initWithNibName:@"EncounterViewController" bundle:nil];
    newEncountersViewController.info = info;
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];

}
-(void)demography:(id)sender:(PatientInfo*)patientInfo{
    RegisterPatientViewController *rController = [[RegisterPatientViewController alloc]initWithNibName:@"RegisterPatientViewController" bundle:nil];
    rController.fromEditCall = YES;
    rController.patientInfo = patientInfo;
    [self.navigationController pushViewController:rController animated:YES];
    [rController release];
}


- (void)dealloc
{
    [practiceID release];
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
    
    
    appDelegate = (Medtec_medical_incAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    isRentSelected = NO;
    isBuySelected = NO;
    providerPickerIndex = 0;
    curOption=-1;
    practiceID=[[NSString alloc] init];
    // Do any additional setup after loading the view from its nib.
    
   /* appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
  //  self.navigationItem.hidesBackButton = YES;
    [self.view addSubview:appHeaderView];*/
    
   
    searchTableBgImage.userInteractionEnabled=YES;
    
   searchPatientTableView = [[UITableView alloc]initWithFrame:CGRectMake(17, 45, 970, 220)];
    searchPatientTableView.backgroundColor = [UIColor clearColor];
    searchPatientTableView.delegate= self;
    searchPatientTableView.dataSource =self;
    //[self.view addSubview:searchPatientTableView];
    [searchTableBgImage addSubview:searchPatientTableView];
    
    //adding calender view
    tdView=[[TdCalendarView alloc]initWithFrame:CGRectMake(400, 2000, 320, 260)];
    tdView.backgroundColor=[UIColor colorWithRed:210/255.0 green:209/255.0 blue:213/255.0 alpha:1.0];
    tdView.calendarViewDelegate=self;    
    
    UIBarButtonItem *rightB = [[UIBarButtonItem alloc]initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(logOutAction)];
    self.navigationItem.rightBarButtonItem = rightB;
    [rightB release];
    
    
    if (appDelegate.providersArray != nil && [appDelegate.providersArray count] > 0 ) {
        Provider *provider = [appDelegate.providersArray objectAtIndex:0];
        selectProviderTxt.text = provider.fullName;
        practiceID= provider.practiceId;
    }else{
        GetProviderIDs *getProvidersId = [[GetProviderIDs alloc]init];
        [getProvidersId providerIdsMethod];
    }
  
}


-(void)logOutAction
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated
{ 
    
    
    NSDate *currentDateTime = [NSDate date];  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];   
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    currentDate.text = [dateFormatter stringFromDate:currentDateTime];    
    //NSLog(@"\nCurrent date is :%@", currentDate.text);
    [dateFormatter release];
    
    NSDate *now = [NSDate date];    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"hh:mm:ss";
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];    
    currentTime.text=[formatter stringFromDate:now];
    //NSLog(@"\nThe Current Time is %@",currentTime.text);
    [formatter release];   
    
//    
//    if (curOption != -1)
//    {
//        NSLog(@"____________VIEW WILL APPEAR______");
//        [self callSearchPatientWebServices];          
//    }
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
