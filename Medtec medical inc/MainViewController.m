//
//  MainViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MainViewController.h"
#import "RegisterPatientViewController.h"
#import "ManageSettingsViewController.h"
#import "SearchPatientViewController.h"
#import "SearchEquipmentViewController.h"
#import "CaptureSignatureViewController.h"
#import "MainTableViewCell.h"
#import "AppHeaderView.h"
#import "Medtec_medical_incAppDelegate.h"
#import "GetProviderIDs.h"
#import "JSON.h"
#import "MessageTableViewCell.h"
#import "NewEncountersViewController.h"

#define kMainTableCellHeight 130


@implementation MainViewController
@synthesize originalTableHeight;

static MainViewController *mainViewControllerSharedData;
+(MainViewController *)mainViewControllerSharedData
{
    return mainViewControllerSharedData;
}
-(void)setSharedMainViewData :(MainViewController *)mainViewController
{
    
    mainViewControllerSharedData = mainViewController;
}

- (NSString *)dataFilePathForPassword 
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"PasswordData.plist"];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    passwordString = textField.text;
    return YES;
}
-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(IBAction)searchPatientButtonClicked:(id)sender
{
    curOption=1;
    searchPatientViewController = [[SearchPatientViewController alloc]init];
    [self.navigationController pushViewController:searchPatientViewController animated:YES];
    
}
-(IBAction)newPatientButtonClicked:(id)sender
{
   // registerPatientViewController = [[RegisterPatientViewController alloc] init]; 
   // [self.navigationController pushViewController:registerPatientViewController animated:YES];
    curOption=1;
    RegisterPatientViewController *rController = [[RegisterPatientViewController alloc]initWithNibName:@"RegisterPatientViewController" bundle:nil];
    [self.navigationController pushViewController:rController animated:YES];
    [rController release];
   
    
}
-(IBAction)calenderViewButtonClicked:(id)sender
{
        if (tdCalenderView != nil)
    {
        [tdCalenderView release];
    }
    tdCalenderView=[[TdCalendarView alloc]initWithFrame:CGRectMake(350, 420, 320, 271)];
    tdCalenderView.backgroundColor=[UIColor colorWithRed:210/255.0 green:209/255.0 blue:213/255.0 alpha:1.0];
    tdCalenderView.calendarViewDelegate=self;
    [self.view addSubview:tdCalenderView];

}

- (void) selectDateChanged:(CFGregorianDate) selectDate
{
    /////////////
    //NSLog(@"selectDateChanged");
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
    tdCalenderView.hidden = YES;
   // NSLog(@"Date in search patient view is %@",selectedDate);
    
}

- (void)dealloc
{
    [encountersArray release];
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
    [self.navigationController setNavigationBarHidden:NO];
    
    NSDate *currentDateTime = [NSDate date];  
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];   
   [dateFormatter setDateFormat:@"YYYY/MM/dd"];
    currentDate.text = [dateFormatter stringFromDate:currentDateTime];    
    NSLog(@"\nCurrent date is :%@", currentDate.text );
    [dateFormatter release];
    
//    if (curOption !=-1)
//    {
//        [self getCurrentEncounters];
//    }
}
-(void)viewWillDisappear:(BOOL)animated
{
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton = TRUE;
    //visitsTable.hidden=YES;    
    appDelegate = (Medtec_medical_incAppDelegate *)[[UIApplication sharedApplication] delegate];    
    
    appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];
    curOption=-1;
    encountersArray=[[NSMutableArray alloc] init];
    
    GetProviderIDs *gData = [GetProviderIDs sharedDataSource];
    [gData providerIdsMethod];
    
    
    
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.    
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    if (tableView==visitsTable) {
        return 5;
    }
    return 1;//return [encountersArray count];

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   
    
    if (tableView==visitsTable) 
    {
        
        static NSString *customCellIdentifier =@"CustomCellIdentifier";
        //NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
        MainTableViewCell *cell=(MainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
                if (cell==nil) 
                {
                    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
                    {
                        NSArray *topObject=[[NSBundle mainBundle] loadNibNamed:@"MainTableViewCell" owner:nil options:nil];
                        for (id object in topObject) 
                        {
                            if ([object isKindOfClass:[MainTableViewCell class]]) {
                                cell =(MainTableViewCell *)object;
                            }
                        }						
                    }
                        
                }	
                
               
                
                //cell.target=self;
                switch (indexPath.row) {
                    case 0:
                        {
                            cell.datelbl.text=@"08/02/12";
                            cell.timelbl.text=@"11:30 AM";
                            cell.patientlbl.text=@"John Smith";
                            cell.providerlbl.text=@"Hamad";
                            cell.newPatientlbl.text =@"Yes";
                            cell.statuslbl.text=@"Open";
                        }            
                        break;
                    case 1:
                    {
                        cell.datelbl.text=@"08/02/12";
                        cell.timelbl.text=@"02:00 PM";
                        cell.patientlbl.text=@"Thomas";
                        cell.providerlbl.text=@"Ramadurai";
                        cell.newPatientlbl.text =@"No";
                        cell.statuslbl.text=@"New";
                    }            
                        break;
                    case 2:
                    {
                        cell.datelbl.text=@"08/02/12";
                        cell.timelbl.text=@"10:30 AM";
                        cell.patientlbl.text=@"Clark";
                        cell.providerlbl.text=@"Hoeltgen";
                         cell.newPatientlbl.text =@"No";
                        cell.statuslbl.text=@"Open";
                    }            
                        break;
                    case 3:
                    {
                        cell.datelbl.text=@"08/02/12";
                        cell.timelbl.text=@"3:00 PM";
                        cell.patientlbl.text=@"Anderson";
                        cell.providerlbl.text=@"Sherman";
                         cell.newPatientlbl.text =@"Yes";
                        cell.statuslbl.text=@"Open";
                    }            
                        break;
                    case 4:
                    {
                        cell.datelbl.text=@"08/02/12";
                        cell.timelbl.text=@"2:30 PM";
                        cell.patientlbl.text=@"Richard";
                        cell.providerlbl.text=@"Paner";
                         cell.newPatientlbl.text =@"Yes";
                        cell.statuslbl.text=@"New";
                    }            
                        break;
                        
                    default:
                        break;
                }   
        cell.mainViewController=self;
        
		return cell;
    }
    
    else
    {        
        
        static NSString *customCellIdentifier =@"CustomCellIdentifier";
        //NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
        MessageTableViewCell *cell=(MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
        if (cell==nil) 
        {
            if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
            {
                NSArray *topObject=[[NSBundle mainBundle] loadNibNamed:@"MessageTableViewCell" owner:nil options:nil];
                for (id object in topObject) 
                {
                    if ([object isKindOfClass:[MessageTableViewCell class]]) {
                        cell =(MessageTableViewCell *)object;
                    }
                }						
            }
            
        }	
        
        switch (indexPath.row) 
        {
            case 0:
            {
                 cell.encounterLabel.text=@"7/28";
                 cell.patientName.text=@"John Doe";
                 cell.message.numberOfLines=3;
                 cell.message.text=@"Missing emergency contact";               
                 cell.status.text=@"New";
            }
            break;
                
            default:
                break;
        }
        
        cell.mainViewController=self; 
        
        return cell;       
        
    } 
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==visitsTable) 
    {
        return 70;
    }
	return 50;
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

-(void)newEncounter:(id)sender
{
   
    NewEncountersViewController *newEncountersViewController = [[NewEncountersViewController alloc] initWithNibName:@"EncounterViewController" bundle:nil];
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
    
}

-(void)newEncounterFromMessage:(id)sender
{
    NewEncountersViewController *newEncountersViewController = [[NewEncountersViewController alloc] initWithNibName:@"EncounterViewController" bundle:nil];
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
    
}
-(void)demography:(id)sender{
    
    RegisterPatientViewController *rController = [[RegisterPatientViewController alloc]initWithNibName:@"RegisterPatientViewController" bundle:nil];
    [self.navigationController pushViewController:rController animated:YES];
    [rController release];
    
}

#pragma mark - Webservices

-(void) getCurrentEncounters
{
    //[createEncounterDict setObject:@"1" forKey:@"StatusID"];
    
    //NSLog(@"\nCreateEncounterDict dict = %@",createEncounterDict);
    
    NSMutableDictionary *getAllEncounterDict=[[NSMutableDictionary alloc] initWithCapacity:0];
    
    id jsonRequest = [getAllEncounterDict JSONRepresentation];
    
    NSURL *url = [NSURL URLWithString:@"http://www.medtecp3.com/MedtecMobilesServices/GetAllPatientEncounters"];
    
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
    
    
  /*  NSURL *url = [NSURL URLWithString:@"http://www.medtecp3.com/MedtecMobilesServices/GetAllPatientEncounters"];
    
    urlRequest = [NSURLRequest requestWithURL:url];
    
    if (webServiceData != nil ) {
        [webServiceData release];
    }
    webServiceData = [[NSMutableData data] retain];
    
    
    if (urlConnection != nil)
    {
        [urlConnection release];
    }
	urlConnection =[[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    
    if (timer  != nil)
    {
        timer = nil;
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cancelConnection:) userInfo:urlConnection repeats:NO];*/
    
    
}     

-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    dataReceived = YES;   
    [webServiceData appendData:data];    
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    [webServiceData setLength:0];    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
	
    if (urlConnection!=nil) 
    {
        [urlConnection release];
    }        
    if (webServiceData!=nil) 
    {
        [webServiceData release];
    }
    
	NSLog(@"Error is %@",error);	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection
{
    
    NSString *strResponse = [[NSString alloc]initWithData:webServiceData encoding:NSUTF8StringEncoding];
    
    NSLog(@"\nstrResponse =%@",strResponse);
    
    if (strResponse !=nil && [strResponse length] >0) 
    {
        SBJSON *json = [[SBJSON new] autorelease];    
        id result = [json objectWithString:strResponse error:nil];
        
        NSString *responseString = [result objectForKey:@"result"];
        NSLog(@"\nResult  from server is %@",responseString);
        if ([responseString isEqualToString:@"Success"])
        {
            visitsTable.hidden=NO;
            [visitsTable reloadData];
        }
        else
        {
            UIAlertView *resultAlert = [[UIAlertView alloc] initWithTitle:@"Encounters are not available" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [resultAlert show];
            [resultAlert release];
        }
    }       
    
}


-(void)cancelConnection:(NSTimer *)myTimer
{
    NSURLConnection *tempConnection = [myTimer userInfo];
    if([tempConnection isEqual:urlConnection])
    {
        if (dataReceived == NO)
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
