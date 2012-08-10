//
//  AppFooterView.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSMutableDictionary *global_userDetails;
@interface AppFooterView : UIView 
{
    UIButton *checkMarkButton;
    UILabel  *agreedTermsAndConcentLabel;
    UILabel  *patientNameLabel;
    UILabel  *dateLabel;
    UIButton *signatureButton;
    
    BOOL checkMarkButtonClicked;
    
}
@property(nonatomic,assign)UIButton *signatureButton;
-(void)checkMarkButtonClicked;
@end
