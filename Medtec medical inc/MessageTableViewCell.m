//
//  MessageTableViewCell.m
//  Medtec medical inc
//
//  Created by Deepika on 31/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "MainViewController.h"

@implementation MessageTableViewCell
@synthesize encounterLabel,patientName,message,status;
@synthesize mainViewController;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    [mainViewController demography:sender];
}
-(IBAction)viewEncounter:(id)sender
{
    [mainViewController newEncounterFromMessage:sender];
}
-(IBAction)replyViaEmail:(id)sender
{
    
}

-(void)dealloc
{
    [encounterLabel release];
    [patientName release];
    [message release];
    [status release];
    [super dealloc];
}

@end
