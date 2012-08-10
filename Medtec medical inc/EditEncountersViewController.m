//
//  EditEncountersViewController.m
//  Medtec medical inc
//
//  Created by Deepika on 28/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "EditEncountersViewController.h"
#import "AppHeaderView.h"
#import "EncounterTableCell.h"
#import "AccessoryTableViewCell.h"

@implementation EditEncountersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    [scrollView setContentSize:CGSizeMake(1000, 2000)];
   /* appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];*/
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
     [textField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{   
     [textField resignFirstResponder];
    return YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView== encounterListTable) 
        return 3;
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView== encounterListTable) 
        return 50;
    
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView== encounterListTable) 
    {
        static NSString *customCellIdentifier =@"CustomCellIdentifier";
        //NSString *customCellIdentifier = [NSString stringWithFormat:@"Cell%d",indexPath.row];
        EncounterTableCell *cell=(EncounterTableCell *)[tableView dequeueReusableCellWithIdentifier:customCellIdentifier];
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

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
