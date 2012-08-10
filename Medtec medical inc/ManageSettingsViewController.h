//
//  ManageSettingsViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 27/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppHeaderView;
@interface ManageSettingsViewController : UIViewController <UITextFieldDelegate>
{
    IBOutlet UITextField *passwordtextField;
    NSString  *passwordString;
    
    AppHeaderView  *appHeaderView;
}
-(IBAction)saveButtonClicked:(id)sender;
-(void)storePasswordInFile;
@end
