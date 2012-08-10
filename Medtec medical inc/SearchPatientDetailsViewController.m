//
//  SearchPatientDetailsViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 10/04/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SearchPatientDetailsViewController.h"
#import "AppHeaderView.h"
#import "DemographicsView.h"
#import "MainViewController.h"
#import "NewEncountersViewController.h"
#import "RegisterPatientViewController.h"
#import "JSON.h"
#import "EditEncountersViewController.h"

@implementation SearchPatientDetailsViewController
@synthesize  selecteddictionary;

- (NSString *)dataFilePathForImages
{ 
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:@"images.plist"];
}
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
    [firstNameTxt resignFirstResponder];
    [lastNameTxt resignFirstResponder];
    [dobTxt resignFirstResponder];
    [addressTxt resignFirstResponder];
    [cityTxt resignFirstResponder];
    [stateTxt resignFirstResponder];
    [zipTxt resignFirstResponder];
    [phoneTxt resignFirstResponder];
    [insurenceIdTxt resignFirstResponder];
    [insurenceNameTxt resignFirstResponder];
    [emergencyContactTxt resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(IBAction)addToVisit:(id)sender
{
    EditEncountersViewController *newEncountersViewController = [[EditEncountersViewController alloc] initWithNibName:@"EditEncounterViewController" bundle:nil];       
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
    
}

-(IBAction)newEncountersButtonClicked:(id)sender
{
    NewEncountersViewController *newEncountersViewController = [[NewEncountersViewController alloc] initWithNibName:@"EncounterViewController" bundle:nil];
    newEncountersViewController.patientId=[selecteddictionary objectForKey:@"PatientID"];
    newEncountersViewController.patientDictionary=selecteddictionary;
    [self.navigationController pushViewController:newEncountersViewController animated:YES];
    [newEncountersViewController release];
}
-(IBAction)copyEncountersButtonClicked:(id)sender
{
    
}
-(IBAction)showEncountersButtonClicked:(id)sender
{
    
}
-(IBAction)homeButtonClicked:(id)sender
{
    if (mainViewController != nil)
    {
        [mainViewController release];
    }
    mainViewController = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainViewController animated:YES];
}
-(IBAction)alertsButtonClicked:(id)sender
{
    
}
-(IBAction)searchButtonClicked:(id)sender
{
    
}
-(IBAction)newPatientButtonClicked:(id)sender
{    
    RegisterPatientViewController *registerPatient  = [[RegisterPatientViewController alloc] init];
    [self.navigationController pushViewController:registerPatient animated:YES];
    [registerPatient release];
}

-(IBAction)editButtonClicked:(id)sender
{
//    fromDeleteMethod = NO;
//
//    
//   
//
//    
//    NSMutableDictionary *editquestionDict = [[NSMutableDictionary alloc]init];
//    [editquestionDict setObject:@"1" forKey:@"PracticeID"];
//    
//    
//    [editquestionDict setObject:[NSString stringWithFormat:@"%@",[selecteddictionary objectForKey:@"PatientID"]] forKey:@"PatientID"];
//    
//    id jsonRequest = [editquestionDict JSONRepresentation];   
//    
//    NSLog(@"%@",jsonRequest);
//    
//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.100/TestingApps/MedtecMobilesServices/EditPatientInfo"];    
//    searchPatienteditRequest = [NSMutableURLRequest requestWithURL:url
//                                                         cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
//    
//    
//    NSData *editPatientdeleteData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
//    
//    [searchPatienteditRequest setHTTPMethod:@"POST"];
//    [searchPatienteditRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [searchPatienteditRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//       
//    [searchPatienteditRequest setValue:[NSString stringWithFormat:@"%d", [editPatientdeleteData length]] forHTTPHeaderField:@"Content-Length"];        
//    [searchPatienteditRequest setHTTPBody:editPatientdeleteData];
// 
//    
//     
//    
//    
//    if (searchPatienteditConnection != nil)
//    {
//        [searchPatienteditConnection release];
//    }
//    
//    searchPatienteditConnection = [[NSURLConnection alloc]initWithRequest:searchPatienteditRequest delegate:self];
//    
//    
//    searchPatienteditWebServiceData = [[NSMutableData data] retain];	
//    
//    if (edittimer  != nil)
//    {
//       edittimer = nil;
//    }
//    edittimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cancelConnection:) userInfo:searchPatienteditConnection repeats:NO];
    
    
    
    
    registerPatientViewController  = [[RegisterPatientViewController alloc] init];
    registerPatientViewController.fromEditCall = YES;
    registerPatientViewController.fromEditDict = selecteddictionary;
    [self.navigationController pushViewController:registerPatientViewController animated:YES];
    
    
}



-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data
{
    
    if (fromDeleteMethod ==YES)
    {
        searchPatientdeleteDataRecived = YES;
        [searchPatientdeleteWebServiceData appendData:data];

    }
    else
    {
    searchPatienteditDataRecived = YES;
    [searchPatienteditWebServiceData appendData:data];
    }
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response
{
    if (fromDeleteMethod ==YES)
    {
        [searchPatientdeleteWebServiceData setLength:0];
 
    }
    else
    {
        [searchPatienteditWebServiceData setLength:0];
        
    }
    
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
    if (searchPatienteditConnection!=nil) {
        [searchPatienteditConnection release];
    }
	
    if (searchPatienteditWebServiceData!=nil) 
    {
        [searchPatienteditWebServiceData release];
    }
    
   editactivityIndicator.hidden=YES;
	//NSLog(@"Error is %@",error);	
}


    -(void)connectionDidFinishLoading:(NSURLConnection *)aConnection
    {
        
        if (fromDeleteMethod == YES) 
        {
            NSString *strResponse = [[NSString alloc]initWithData:searchPatientdeleteWebServiceData encoding:NSUTF8StringEncoding];
            
            NSLog(@"\nstrResponse =%@",strResponse);
            
            if (strResponse !=nil && [strResponse length] >0) 
            {
                SBJSON *json = [[SBJSON new] autorelease];    
                id result = [json objectWithString:strResponse error:nil];
                
                searchPatienteditResponseDict = [[NSMutableDictionary alloc] initWithCapacity:0];
                searchPatienteditResponseDict =result;
                //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[searchPatienteditResponseDict objectForKey:@"result"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                //            [alert show];
                
                if ([[searchPatienteditResponseDict objectForKey:@"result"] isEqualToString:@"Success"] )
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success" message:@"Deleted Patient successfully" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    alert.tag=1;
                    [alert show];
                    [alert release];
                    
                }
                else
                {
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to Delete Patient" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                    [alert release];
                    
                }
                
            }
        }
        else
        {
            NSString *strResponse = [[NSString alloc]initWithData:searchPatienteditWebServiceData encoding:NSUTF8StringEncoding];
            
            // NSLog(@"\nedit service strResponse =%@",strResponse);
            
            SBJSON *json = [[SBJSON new] autorelease];    
            id result = [json objectWithString:strResponse error:nil];
            
            searchPatienteditResponseDict = [[NSMutableDictionary alloc] initWithCapacity:0];
            searchPatienteditResponseDict =result;
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[searchPatienteditResponseDict objectForKey:@"result"] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        
        
    }
    
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (alertView.tag==1) 
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

   

-(IBAction)deleteButtonClicked:(id)sender
{
    fromDeleteMethod = YES;

    NSMutableDictionary *questionDict = [[NSMutableDictionary alloc]init];
    //[questionDict setObject:@"1" forKey:@"PracticeID"];
    
     [questionDict setObject:[global_userDetails objectForKey:@"PracticeID"] forKey:@"PracticeID"];    
    
    [questionDict setObject:[NSString stringWithFormat:@"%@",[selecteddictionary objectForKey:@"PatientID"]] forKey:@"PatientID"];
    
     id jsonRequest = [questionDict JSONRepresentation];   
    
    NSLog(@"\nDelete patient request is %@",questionDict);

//    NSURL *url = [NSURL URLWithString:@"http://192.168.1.100/TestingApps/MedtecMobilesServices/DeletePatientInfo"];    
    
       NSURL *url = [NSURL URLWithString:@"http://www.medtecp3.com/MedtecMobilesServices/DeletePatientInfo"];
    
    searchPatientdeleteRequest = [NSMutableURLRequest requestWithURL:url
                                              cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    
    NSData *searchPatientdeleteData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
    
    [searchPatientdeleteRequest setHTTPMethod:@"POST"];
    [searchPatientdeleteRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [searchPatientdeleteRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [searchPatientdeleteRequest setValue:[NSString stringWithFormat:@"%d", [searchPatientdeleteData length]] forHTTPHeaderField:@"Content-Length"];        
    [searchPatientdeleteRequest setHTTPBody: searchPatientdeleteData];
    
    if (searchPatientdeleteConnection != nil)
    {
        [searchPatientdeleteConnection release];
    }
    
    searchPatientdeleteConnection = [[NSURLConnection alloc]initWithRequest:searchPatientdeleteRequest delegate:self];
    
    
    searchPatientdeleteWebServiceData = [[NSMutableData data] retain];	
    
    if (deletetimer  != nil)
    {
        deletetimer = nil;
    }
    deletetimer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cancelConnection:) userInfo:searchPatientdeleteConnection repeats:NO];
    
    
    
}



-(IBAction)insurenceCard1ButtonClicked:(UIButton *)insurenceCard
{
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) 
    {
        [self presentModalViewController:cameraPickerController animated:YES];
    } 
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Camera not available" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
    }
    
    
    senderTag = insurenceCard.tag;
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissModalViewControllerAnimated:YES];
    
    NSData *imageData =UIImagePNGRepresentation(image1);;
    
    if (senderTag == 1)
    {
    
        [insurenceCard1 setImage:image1 forState:UIControlStateNormal];
        [imagesDict setObject:imageData forKey:@"image1"];
    }
    else
    {
        [insurenceCard2 setImage:image1 forState:UIControlStateNormal];
        [imagesDict setObject:imageData forKey:@"image2"];
    }
    NSString *filePath = [self dataFilePathForImages];
    [imagesDict writeToFile:filePath atomically:YES];
}

- (void)dealloc
{
    [super dealloc];
    [imagesDict release];
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
    NSString *filePath = [self dataFilePathForImages];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        imagesDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [insurenceCard1 setImage:[UIImage imageWithData:[imagesDict objectForKey:@"image1"]] forState:UIControlStateNormal];
        [insurenceCard2 setImage:[UIImage imageWithData:[imagesDict objectForKey:@"image2"]] forState:UIControlStateNormal];

    }
    else
    {
        imagesDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    }
    
    
}
- (void)viewDidLoad
{
   
    [super viewDidLoad];
    //NSLog(@"deleted dictionary is %@",selecteddictionary);
    [selecteddictionary setObject:@"" forKey:@"PracticeID"];
    [selecteddictionary setObject:[selecteddictionary objectForKey:@"PatientID"] forKey:@"PatientID"];
    
    NSLog(@"current patient id is %@",[selecteddictionary objectForKey:@"PatientID"]);


    firstNameTxt.text = [selecteddictionary objectForKey:@"FirstName"];// retriveing data
   lastNameTxt.text =[selecteddictionary objectForKey:@"LastName"];
    dobTxt.text=[selecteddictionary objectForKey:@"Date_Of_Birth"];
    insurenceIdTxt.text=[selecteddictionary objectForKey:@"Insurance1ID"];
    insurenceNameTxt.text=[selecteddictionary objectForKey:@"insurenceNameTxt"];
    emergencyContactTxt.text=[selecteddictionary objectForKey:@"Emergency_Contact_Num"];
    phoneTxt.text=[selecteddictionary objectForKey:@"PhoneNumber1"];
    addressTxt.text=[selecteddictionary objectForKey:@"Address1"];
    stateTxt.text=[selecteddictionary objectForKey:@"State"];
    cityTxt.text=[selecteddictionary objectForKey:@"City"];
    zipTxt.text=[selecteddictionary objectForKey:@"Zip"];
    sexTxt.text=[selecteddictionary objectForKey:@"Sex"];                  
                         
    // Do any additional setup after loading the view from its nib.
    appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];
    demoGraphicsView = [[DemographicsView alloc] initWithFrame:CGRectMake(0, 50, 1024, 50)];
    [self.view addSubview:demoGraphicsView];
    
    
    cameraPickerController = [[UIImagePickerController alloc] init];
    cameraPickerController.delegate = self;
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) 
    {
        cameraPickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
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

-(void)cancelConnection:(NSTimer *)myTimer
{
    if (fromDeleteMethod == YES)
    {
        NSURLConnection *tempConnection = [myTimer userInfo];
        if([tempConnection isEqual:searchPatientdeleteConnection])
        {
            if (searchPatientdeleteDataRecived == NO)
            {
                //[activityIndicator stopAnimating];
                [searchPatientdeleteConnection cancel];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                [alert release];
            }
            deletetimer = nil;
        }
        
    }
    else
    {
        NSURLConnection *tempConnection = [myTimer userInfo];
        if([tempConnection isEqual:searchPatienteditConnection])
        {
            if (searchPatienteditDataRecived == NO)
            {
                //[activityIndicator stopAnimating];
                [searchPatienteditConnection cancel];
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
                [alert show];
                [alert release];
            }
            edittimer = nil;
        }

    }
   
}


@end
