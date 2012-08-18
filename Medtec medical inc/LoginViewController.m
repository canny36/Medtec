//
//  LoginViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "Medtec_medical_incAppDelegate.h"
//#import "SBJSON.h"
#import "JSON.h"
#import"BordersView.h"
#import "MedTecNetwork.h"

@implementation UINavigationBar (UINavigationBarCategory)  
- (void)drawRect:(CGRect)rect  
{  
    UIImage *image = [UIImage imageNamed:@"logo.png"];  
   	[image drawInRect:rect];  
}  
@end


@interface LoginViewController()
  
-(void)showProgress :(NSString*)message;
-(void)hideProgress;
-(void)showAlert:(NSString*)message:(id<UIAlertViewDelegate>)delegate;
-(void)login;

@end
    
@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [loginResponseDict release];
    [super dealloc];
}

#pragma mark - Login Button

-(IBAction)loginButtonClicked:(id)sender
{
    [buffertxtField resignFirstResponder];
    [self pickerViewanimation:2000 : 2000];
    [self viewanimation:0];  
        
    if ([userNameTextField.text length] > 0 && [passwordTextField.text length]>0 && [practiseOrLocationTextField.text length]>0)
    {
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
//        [activityIndicator startAnimating];
        
        [self login];
    }
    else
    {
        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:nil message:@"Enter all details" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertNetwork show];
        [alertNetwork release];
    }
    
       
}

#pragma mark - (ToolBar) Done Button

-(IBAction)DoneAction:(id)sender
{
    [self pickerViewanimation:2000 : 2000];
    [self viewanimation:0];
   // NSLog(@"index : %d",pickerIndex);
    
    if([sender tag] == 20)
        practiseOrLocationTextField.text = [praciceNameArray objectAtIndex:pickerIndex];
}

#pragma mark - Animations


-(void)pickerViewanimation:(int)value :(int)toolValue
{
	CGRect viewFrame = CGRectMake(319, value, practicePicker.frame.size.width, practicePicker.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[practicePicker setFrame:viewFrame];
	[UIView commitAnimations];
    [self.view bringSubviewToFront:practicePicker];
	
	CGRect newToolBarFrame = CGRectMake(319, toolValue, toolBar.frame.size.width, toolBar.frame.size.height);
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration: 0.3];
	[toolBar setFrame: newToolBarFrame];
	[UIView commitAnimations];
	
	
}


-(void)viewanimation:(int)value 
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration: 0.3];
    scrollView.contentOffset = CGPointMake(0, value);
    [UIView commitAnimations];
}

-(IBAction)forgotPasswordButtonClicked:(id)sender
{
    
}

#pragma mark - Text Field Delegate


//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    buffertxtField = textField;
//    if (textField == practiseOrLocationTextField) 
//    {
//        [textField resignFirstResponder];
//        [self viewanimation:100];
//        [self pickerViewanimation:490 :446];
//        return NO;
//        
//    }
//    return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == practiseOrLocationTextField) 
    {
        [userNameTextField resignFirstResponder];
        [passwordTextField resignFirstResponder];
        [textField resignFirstResponder];
        [self viewanimation:100];
        [self pickerViewanimation:490 :446];
    }
   else	
   {  
       [self viewanimation:0];
       [self pickerViewanimation:2000 :2000];
   }
        
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
//    if (textField == userNameTextField)
//    {
//        [loginDetailsDict setObject:userNameTextField.text forKey:@"UserName"];
//    }
//    else if(textField == passwordTextField)
//    {
//        [loginDetailsDict setObject:passwordTextField.text forKey:@"Password"];
// 
//    }
//   if(textField ==practiseOrLocationTextField)
//    {
//       // [loginDetailsDict setObject:practiseOrLocationTextField.text forKey:@"PracticeName"];
//        [self viewanimation:0];
//
//    }
    [textField resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self viewanimation:0];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [userNameTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    [practiseOrLocationTextField resignFirstResponder];
}

-(void)validDeatils
{
       
}


#pragma mark - Get Practice Data

-(void)practiceDataMethod
{
    NSLog(@" PRACTICE METHOD GETALLPRACTICES = %@ ",URL_GETPRACTICES);
    
    NSURL *url = [NSURL URLWithString:URL_GETPRACTICES];
    NSURLRequest *getAllPracticesRequest = [NSURLRequest requestWithURL:url];
	dataConnection =[[NSURLConnection alloc] initWithRequest:getAllPracticesRequest delegate:self];	

}


-(void)login{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:userNameTextField.text forKey:@"UserName"];
    [dic setObject:passwordTextField.text forKey:@"Password"];
    [dic setObject:practiseOrLocationTextField.text forKey:@"PracticeName"];
 
    [self showProgress:@"Logging in.."];
    MedTecNetwork *medtecNetwork = [MedTecNetwork shareInstance];
    [medtecNetwork login: dic : self];
    
}

-(void) showAlert:(NSString*)message:(id<UIAlertViewDelegate>)delegate{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Alert" message:message delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    if(delegate!=nil)
        alertView.tag = 10;
    
    [alertView show];
    [alertView release];
}

#pragma mark - Network delegate methods

-(void)onSuccess:(id)result:(int)call{
    
    
    [self hideProgress];
    NSLog(@" Succesfully loged in ");
    

    NSLog(@"LOGIN RESPONSE %@ ",result);
    
    [loginResponseDict removeAllObjects];
    if ([result isKindOfClass:[NSDictionary class]]) 
        [loginResponseDict addEntriesFromDictionary:(NSDictionary *)result];
    else  if ([result isKindOfClass:[NSArray class]] && [result count] >0) 
        [loginResponseDict addEntriesFromDictionary:[result objectAtIndex:0]];
    
    // NSLog(@"%@",result);
//    [activityIndicator stopAnimating];
    [self loginWebServiceResponseMethod];

}

-(void)onError:(NSString*)errorMsg :(int)call{
    
    [self hideProgress];

       NSLog(@" Error while logging in. ");
    [self showAlert:@"Failed to login" :nil];
}


-(void)onConnectionTimeOut{
    
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



/////////////////
-(void)callAuthenticationWebServices
{
  
    
    if([appDelegate isNetWorkAvailable]==NO)
    {
        [activityIndicator stopAnimating];
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:@"Network Status" message:@"Sorry, network is not available. Please try again later." delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertNetwork show];
        [alertNetwork release];
        return;
        
    }
    else
    {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:userNameTextField.text forKey:@"UserName"];
        [dic setObject:passwordTextField.text forKey:@"Password"];
        [dic setObject:practiseOrLocationTextField.text forKey:@"PracticeName"];
        id jsonRequest = [dic JSONRepresentation];
      
        NSLog(@"LOGIN REQUEST %@ ",dic);
        NSLog(@"check user login %@ ",URL_CHECKUESERLOGIN);
    NSURL *url = [NSURL URLWithString:URL_CHECKUESERLOGIN];

        
   loginUrlRequest = [NSMutableURLRequest requestWithURL:url
                                                               cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        
        
        NSData *requestData = [NSData dataWithBytes:[jsonRequest UTF8String] length:[jsonRequest length]];
        
        [loginUrlRequest setHTTPMethod:@"POST"];
        [loginUrlRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [loginUrlRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [loginUrlRequest setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
       
        [loginUrlRequest setHTTPBody: requestData];
        
        if (loginConnection != nil)
        {
            [loginConnection release];
        }
        
        loginConnection = [[NSURLConnection alloc]initWithRequest:loginUrlRequest delegate:self];
        
        if (timer  != nil)
        {
            timer = nil;
        }
        timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(cancelConnection:) userInfo:loginConnection repeats:NO];
        
        
    }
}


-(void)connection:(NSURLConnection *)aConnection didReceiveData:(NSData *)data // DATA DIVIDED IN TO PARTS...
{
    if(aConnection == dataConnection)
    {
         [practiceData appendData:data];
    }
    else
    {
        loginDataReceived = YES;
        [loginWebServiceData appendData:data];
    }
    
}


-(void)connection:(NSURLConnection *)aConnection didReceiveResponse:(NSURLResponse *)response //WE GET THE RESPONSE HERE...
{
    
    NSHTTPURLResponse *httpresponse = (NSHTTPURLResponse*)response;
    NSLog(@" RESPONSE STATUS CODE = %d ",httpresponse.statusCode);
    
    if(aConnection == dataConnection)
    {
        if (practiceData != nil) 
        {
            [practiceData release];
            practiceData = nil;
        }
        practiceData = [[NSMutableData alloc]init];
    }
    else
    {
        if (loginWebServiceData != nil) 
        {
            [loginWebServiceData release];
        }
        loginWebServiceData = [[NSMutableData alloc]init];
    }
   
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
    activityIndicator.hidden=YES;
	NSLog(@"Error is %@",error);	
}

-(void)connectionDidFinishLoading:(NSURLConnection *)aConnection // conn loading is finished here...
{
   
    
  
    if(aConnection == dataConnection)
    {
        if (practiceData != nil) {
            NSString *strResponse = [[NSString alloc]initWithData:practiceData encoding:NSUTF8StringEncoding];
            SBJSON *json = [[SBJSON new] autorelease];    
            id result = [json objectWithString:strResponse error:nil];
            NSLog(@"result of allPractices is  : %@",result);
            
            NSArray *events =result;
            if ([events count] >0) 
            {
                [praciceNameArray addObjectsFromArray:events];
            }
            
            NSLog(@"Practices count is %d and arrary is %@\n",[praciceNameArray count] ,praciceNameArray);
            [strResponse release];
            [practicePicker reloadAllComponents];

        }
        
    }
    else
    {
        NSString *strResponse = [[NSString alloc]initWithData:loginWebServiceData encoding:NSUTF8StringEncoding];
        SBJSON *json = [[SBJSON new] autorelease];    
        id result = [json objectWithString:strResponse error:nil];
        
        
        NSLog(@"LOGIN RESPONSE %@ ",strResponse);

        [loginResponseDict removeAllObjects];
        if ([result isKindOfClass:[NSDictionary class]]) 
            [loginResponseDict addEntriesFromDictionary:(NSDictionary *)result];
        else  if ([result isKindOfClass:[NSArray class]] && [result count] >0) 
            [loginResponseDict addEntriesFromDictionary:[result objectAtIndex:0]];
        
        // NSLog(@"%@",result);
        [activityIndicator stopAnimating];
        [self loginWebServiceResponseMethod];

    }
    
       
}

-(void)loginWebServiceResponseMethod
{
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    [activityIndicator stopAnimating];
    //NSLog(@"%@",loginResponseDict);
    
    if ([loginResponseDict count] >0)
    {
        appDelegate.loginInfo = [[LoginInfo alloc]initWithDictionary:loginResponseDict];
        
       
        MainViewController *mController = [[MainViewController alloc] init];
        [mainViewController setSharedMainViewData:mController];
        [self.navigationController pushViewController:mController animated:YES];
 
    }
    else
    {
        UIAlertView *alertNetwork = [[UIAlertView alloc] initWithTitle:nil message:@"Sorry Login Failed" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertNetwork show];
        [alertNetwork release];

    }
}

#pragma mark - PickerView Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
		
	pickerIndex = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
	
	return [praciceNameArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
        return [praciceNameArray objectAtIndex:row];
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
    //[self.navigationController setNavigationBarHidden:YES];
    
    //userNameTextField.text = @"";
    //passwordTextField.text = @"";
    //practiseOrLocationTextField.text = @"";
}




- (void)viewDidLoad
{
  
    
    [super viewDidLoad];
    loginResponseDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    praciceNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    pickerIndex = 0;
    
    //loginDetailsDict = [[NSMutableDictionary alloc] init];    
    userNameTextField.text = @"ltadmin";
    passwordTextField.text = @"123456";
    practiseOrLocationTextField.text = @"Apolo";
    
    // Do any additional setup after loading the view from its nib.
    appDelegate = (Medtec_medical_incAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    activityIndicator =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2-20);
    activityIndicator.hidden = YES;
    [self.view addSubview:activityIndicator];
    
    [[BordersView sharedDataSource]addlayerToTextField:userNameTextField];
    [[BordersView sharedDataSource]addlayerToTextField:passwordTextField];
    [[BordersView sharedDataSource]addlayerToTextField:practiseOrLocationTextField];
    
    //adding picker
    [self.view addSubview:practicePicker];
    practicePicker.center = CGPointMake(self.view.frame.size.width/2, 2000);
    
    [self.view addSubview:toolBar];
    toolBar.center = CGPointMake(self.view.frame.size.width/2, 2000);
    
    [self practiceDataMethod];

    
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
    NSURLConnection *tempConnection = [myTimer userInfo];
    if([tempConnection isEqual:loginConnection])
    {
        if (loginDataReceived == NO)
        {
            [activityIndicator stopAnimating];
            [loginConnection cancel];
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Network problem " delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alert show];
            [alert release];
        }
        timer = nil;
    }
    
}

@end
