//
//  MainTableViewCell.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@interface MainTableViewCell : UITableViewCell 
{
    IBOutlet UILabel *datelbl;
    IBOutlet UILabel *timelbl;
    IBOutlet UILabel *patientlbl;
    IBOutlet UILabel *providerlbl;
    IBOutlet UILabel *statuslbl;
    IBOutlet UILabel *newPatientlbl;
    MainViewController *mainViewController;
    
}
@property(nonatomic,retain)UILabel *datelbl;
@property(nonatomic,retain)UILabel *timelbl;
@property(nonatomic,retain)UILabel *patientlbl;
@property(nonatomic,retain)UILabel *providerlbl;
@property(nonatomic,retain)UILabel *statuslbl;
@property(nonatomic,retain)UILabel *newPatientlbl;
@property(nonatomic,retain) MainViewController *mainViewController;

-(IBAction)newEncounter:(id)sender;
@end
