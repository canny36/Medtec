//
//  SearchPatientTableViewCell.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "SearchPatientTableViewCell.h"
#import "SearchPatientViewController.h"
#import "PatientInfo.h"
#import "Util.h"

@implementation SearchPatientTableViewCell

@synthesize name;
@synthesize dob;
@synthesize phone;
@synthesize insuranceName;
@synthesize encountersCount;
@synthesize lastVisitDate;
@synthesize searchViewController;
@synthesize patientInfo;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
        
    {
        // Initialization code
            
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(IBAction)viewdemo:(id)sender
{
    [searchViewController demography:sender :patientInfo];
}

-(IBAction)viewEncounter:(id)sender
{
    [searchViewController newEncounter:sender :patientInfo];
}

-(void)loadData:(PatientInfo*)info{
    
   self.name.text = info.firstname;
   self.dob.text = info.dob;
   self.phone.text = [NSString stringWithFormat:@"%d",info.phoneNo];
   self.insuranceName.text = info.insuranceName;   
   self.encountersCount.text = [NSString stringWithFormat:@"%d",info.encountersCount];
   self.lastVisitDate.text = info.lvDate;
  
 }

- (void)dealloc
{
    [name release];
    [dob release];
    [phone release];
    [insuranceName release];
    [encountersCount release];
    [lastVisitDate release];
    [super dealloc];
}

@end
