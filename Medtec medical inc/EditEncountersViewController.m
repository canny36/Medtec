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
#import "MedTecNetwork.h"
#import "Provider.h"
#import "Accessory.h"
@interface EditEncountersViewController()


-(void)getEncounter;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;
-(void)getEncounter;
-(NSString*)getProviderName:(int)_providerId;
-(void)getEncounters;
-(void)onDeliveryTypeSelection:(UIButton*)btn;
-(void)filldata:(NSDictionary*)dict;
@end


#define DELIVERY_NURING @"to nursing facility"
#define DELIVERY_SHIPPING @"Shipping service"
#define DELIVERY_DTOB @"directly to beneficiary"



@implementation EditEncountersViewController

static UIImage *checkedImage;
static UIImage *uncheckedImage;

@synthesize patientID , encounterID;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *leftBack = [[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = leftBack;

    [leftBack release]; 
//    self.navigationController.navigationBarHidden = NO;
//    self.navigationItem.hidesBackButton = NO;
    self.navigationController.navigationBar.backItem.hidesBackButton = NO;
        [scrollView setContentSize:CGSizeMake(700, 700)];
    
    appdelegate = (Medtec_medical_incAppDelegate*)[[UIApplication sharedApplication] delegate];
    accessoryTable.delegate = self;
    accessoryTable.dataSource = self;
    [accessoryTable reloadData];
    
    checkedImage = [UIImage imageNamed:@"CheckBoxHL.png"];
    uncheckedImage = [UIImage imageNamed:@"checkBox.png"];
   
    [self getEncounter];
}

-(void)filldata:(NSDictionary*)dict{
//    {
//        "EncounterID": 8,
//        "PatientID": 74,
//        "EquipID": null,
//        "Date": null,
//        "Notes": null,
//        "Equip_Options": null,
//        "Presc_Physician": null,
//        "Delivery_Method": null,
//        "Start_Refill_Date": null,
//        "Equip_Inspected_By": null,
//        "Equip_Deliv_Date": null,
//        "Facility_Name": null,
//        "Facility_Address": null,
//        "Diagnosis_Codes": null,
//        "Est_Treatment_Dur": null,
//        "Equip_Serial_Num": null,
//        "Type_Of_Equip": null,
//        "Drug": null,
//        "HCPCS_Code": null,
//        "J_Code": null,
//        "Po_Patient_Sign": null,
//        "Po_Patient_Sign_Date": null,
//        "Po_CompanyRep_Sign": null,
//        "Po_Company_Rep_Sign_Date": null,
//        "Po_Equip_Received_Date": null,
//        "Mcr_Beneficiary_Sign": null,
//        "Mcr_Beneficiary_Sign_Date": null,
//        "Mcr_Beneficiary_Name": null,
//        "Mcr_Notes": null,
//        "Pdr_Patient_Sign": null,
//        "Pdr_Patient_Sign_Date": null,
//        "Pdr_Legalguardian_Sign": null,
//        "Pdr_Legalguardian_Name": null,
//        "Pii_Patient_Sign": null,
//        "Pii_Patient_Sign_Date": null,
//        "Pii_Legalguardian_Sign": null,
//        "Pii_Reason_PatientUnsign": null,
//        "Pii_Guardian_Relation": null,
//        "Pii_Guardian_Firstname": null,
//        "Pii_Guardian_Lastname": null,
//        "Pii_Guardian_Address1": null,
//        "Pii_Guardian_Address2": null,
//        "Pii_Guardian_City": null,
//        "Pii_Guardian_State": null,
//        "Pii_Guardian_Zip": null,
//        "Pii_Guardian_Email": null,
//        "Pii_Guardian_Phone": null,
//        "Ptn_Physician_Sign": null,
//        "Ptn_Physician_Sign_Date": null,
//        "Ptn_Physician_Name": null,
//        "Ptn_Intravenous_Conti_Times": null,
//        "Ptn_Intravenous_Conti_Days": null,
//        "Ptn_Continu_Administrat": null,
//        "Ptn_Continu_Adminstrat_IFno": null,
//        "Ptn_Intravenous_Infusion": null,
//        "Ptn_Presc_Of_Equip": null,
//        "Dmeif_Supplier_Sign": null,
//        "Dmeif_Supplier_Sign_Date": null,
//        "Dmeif_Initial_Date": null,
//        "Dmeif_Revised_Date": null,
//        "Dmeif_Recertification_Date": null,
//        "StatusID": null,
//        "patnt": null,
//        "equip": null
//    }
    
    diagnosisCodeTxtField.text = [self getValue:@"Diagnosis_Codes" :dict];
    typeOfInfusionPumpTxtField.text = [self getValue:@"Type_Of_Equip" :dict];
    drugTxtField.text = [self getValue:@"Drug" :dict];
    estimatedTreatDurationTxtField.text = [self getValue:@"Est_Treatment_Dur" :dict];
       pumpSerialTxtField.text = [self getValue:@"Equip_Serial_Num" :dict];
    hcpcsCodeTxtField.text = [self getValue:@"HCPCS_Code" :dict];
    jCodeTxtField.text = [self getValue:@"J_Code" :dict];
//    providerTxtField.text = [[self getProviderName:[self getValue:@"" :dict]]];
   
    
    NSString *value = [self getValue:@"Equip_Options" :dict];
    if ([value isEqualToString:@"Rental"]) {
        rentButton.tag = 1;
        [rentButton setImage:checkedImage forState:UIControlStateNormal];
    }else{
       buyButton.tag = 1;
      [buyButton setImage:checkedImage forState:UIControlStateNormal];

    }
    
    value = [self getValue:@"Delivery_Method" :dict];
   
    if ([value isEqualToString:DELIVERY_DTOB]) {
        
       beneficiaryButton.tag =1;
       [beneficiaryButton setImage:checkedImage forState:UIControlStateNormal];
       [self onDeliveryTypeSelection:beneficiaryButton];

    }else if([value isEqualToString:DELIVERY_NURING]){
        
        nursingButton.tag =1;
        [nursingButton setImage:checkedImage forState:UIControlStateNormal];
        [self onDeliveryTypeSelection:nursingButton];
         
    }else if([value isEqualToString:DELIVERY_SHIPPING]){
        
        shippingButton.tag = 1;
        [shippingButton setImage:checkedImage forState:UIControlStateNormal];
        [self onDeliveryTypeSelection:shippingButton];
        
    }
  
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(NSString*)getProviderName:(int)_providerId{
    NSMutableArray *array = appdelegate.providersArray;
    for (int i = 0 , size = [array count]; i< size ; i++) {
        Provider *provider = [array objectAtIndex:i];
        if (provider.userId == _providerId) {
          return provider.fullName;
        }
    }
    return @"";
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


-(void)getEncounter{
    MedTecNetwork *medtecNetwork = [[MedTecNetwork alloc]init];
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    [bundle setValue:[NSNumber numberWithInt:patientID] forKey:@"PatientID"];
     [bundle setValue:[NSNumber numberWithInt:encounterID] forKey:@"EncounterID"];
    [medtecNetwork getSinglePatientEncounter:bundle :self];
}


#pragma mark - GETEncounters
-(void)getEncounters{
    MedTecNetwork *medtecNetwork = [[MedTecNetwork alloc]init];
    
    NSMutableDictionary *bundle = [[NSMutableDictionary alloc]init];
    
    [bundle setObject: [NSNumber numberWithInt:patientID] forKey:@"PatientID"];
    [medtecNetwork getPatientAllEncounters:bundle :self];
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




#pragma mark - NetworkDelegate
-(void)onSuccess:(id)result:(int)call{
    
    switch (call) {
        case CALL_SINGLEENCOUNTER:
            [self filldata:result];
            break;
        case CALL_ACCESSORIES:
            
           appdelegate.accessoryArray =  [[Accessory collection:result] retain];
            [accessoryTable reloadData];
            break;
        default:
            break;
    }
    
}
-(void)onError:(NSString*)errorMsg :(int)call{
    
}
-(void)onConnectionTimeOut{
    
}

#pragma mark - TAble view delegate methods

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
    return appdelegate.accessoryArray != nil ? appdelegate.accessoryArray.count : 0;
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
        
        Accessory *accessory = [appdelegate.accessoryArray objectAtIndex:indexPath.row];
        
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
