//
//  MainTableViewCell.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "MainTableViewCell.h"
#import "MainViewController.h"


@implementation MainTableViewCell
@synthesize datelbl,timelbl,patientlbl,providerlbl,statuslbl,newPatientlbl;
@synthesize mainViewController;
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

-(IBAction)newEncounter:(id)sender
{
    [mainViewController newEncounter:sender];
}

- (void)dealloc
{
    [datelbl release];
    [timelbl release];
    [patientlbl release];
    [providerlbl release];
    [statuslbl release];
    [newPatientlbl release];
    [super dealloc];
}

@end
