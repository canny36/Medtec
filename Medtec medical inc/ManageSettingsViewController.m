//
//  ManageSettingsViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 27/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "ManageSettingsViewController.h"
#import "AppHeaderView.h"

@implementation ManageSettingsViewController
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [passwordtextField resignFirstResponder];
}
-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)storePasswordInFile
{
    NSMutableDictionary *passwordDict = [[NSMutableDictionary alloc] init];
    [passwordDict setObject:passwordString forKey:@"password"];
    NSString *filePath = [self dataFilePathForPassword];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) 
    {
        [passwordDict writeToFile:filePath atomically:YES]; 
    }
    else
    {
        [passwordDict writeToFile:filePath atomically:YES]; 
    }
    [passwordDict release];
}
-(IBAction)saveButtonClicked:(id)sender
{
    passwordString = passwordtextField.text; 
    [self storePasswordInFile];
}
- (void)dealloc
{
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
    self.navigationItem.hidesBackButton = YES;
    appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];

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
