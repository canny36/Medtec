//
//  SearchPatientTableViewCell.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PatientInfo.h"


@class SearchPatientViewController;
@interface SearchPatientTableViewCell : UITableViewCell 
{
    IBOutlet UILabel *name;
    IBOutlet UILabel *dob;
    IBOutlet UILabel *phone;
    IBOutlet UILabel *insuranceName;
    IBOutlet UILabel *encountersCount;
    IBOutlet UILabel *lastVisitDate;
       
    SearchPatientViewController *searchViewController;
    
    PatientInfo *patientInfo;
}

@property(nonatomic,retain)PatientInfo *patientInfo;
@property (nonatomic,retain)UILabel *name;
@property (nonatomic,retain)UILabel *dob;
@property (nonatomic,retain)UILabel *phone;
@property (nonatomic,retain)UILabel *insuranceName;
@property (nonatomic,retain)UILabel *encountersCount;
@property (nonatomic,retain)UILabel *lastVisitDate;
@property(nonatomic,retain)SearchPatientViewController *searchViewController;

-(IBAction)viewdemo:(id)sender;
-(IBAction)viewEncounter:(id)sender;

-(void)loadData:(PatientInfo*)info;

@end
