//
//  MessageTableViewCell.h
//  Medtec medical inc
//
//  Created by Deepika on 31/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@interface MessageTableViewCell : UITableViewCell
{
    IBOutlet UILabel *encounterLabel;
    IBOutlet UILabel *patientName;
    IBOutlet UILabel *message;
    IBOutlet UILabel *status;
    MainViewController *mainViewController;
}

@property(nonatomic,retain)UILabel *encounterLabel;
@property(nonatomic,retain)UILabel *patientName;
@property(nonatomic,retain)UILabel *message;
@property(nonatomic,retain)UILabel *status;
@property(nonatomic,retain) MainViewController *mainViewController;

-(IBAction)viewdemo:(id)sender;
-(IBAction)viewEncounter:(id)sender;
-(IBAction)replyViaEmail:(id)sender;
@end
