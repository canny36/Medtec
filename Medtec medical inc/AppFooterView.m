//
//  AppFooterView.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AppFooterView.h"
#import "Medtec_medical_incAppDelegate.h"


@implementation AppFooterView
@synthesize signatureButton;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        checkMarkButtonClicked = YES;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bottombar.png"]];
        
        checkMarkButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
        [checkMarkButton setBackgroundImage:[UIImage imageNamed:@"check box .png"] forState:UIControlStateNormal];
        [checkMarkButton addTarget:self action:@selector(checkMarkButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:checkMarkButton];
        
        agreedTermsAndConcentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, 300, 30)];
        agreedTermsAndConcentLabel.text = @"Agreed Terms & Concent";
        agreedTermsAndConcentLabel.textColor = [UIColor whiteColor];
        agreedTermsAndConcentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:agreedTermsAndConcentLabel];
        
        Medtec_medical_incAppDelegate *appDelegate = (Medtec_medical_incAppDelegate*)[[UIApplication sharedApplication] delegate];
        
        NSString *name = @"";
        [name stringByAppendingString:[NSString stringWithFormat:@"%@ %@",appDelegate.loginInfo.firstName,appDelegate.loginInfo.lastName]];
        patientNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(450, 10, 200, 30)];
        
        patientNameLabel.textColor = [UIColor whiteColor];
        patientNameLabel.text = name;
        patientNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:patientNameLabel];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"MM/dd/YYYY"];
        NSString *selected = [dateFormatter stringFromDate:[NSDate date]];
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 10, 200, 30)];
        dateLabel.textColor = [UIColor whiteColor];
        dateLabel.text = selected;
        dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:dateLabel];
        [dateFormatter release];
        
        
        signatureButton = [[UIButton alloc] initWithFrame:CGRectMake(920, 10, 100, 30)];
        [signatureButton setBackgroundImage:[UIImage imageNamed:@"signature.png"] forState:UIControlStateNormal];
        [self addSubview:signatureButton];
        
        
    }
    return self;
}

-(void)checkMarkButtonClicked
{
    if (checkMarkButtonClicked == YES)
    {
        checkMarkButtonClicked = NO;
        [checkMarkButton setBackgroundImage:[UIImage imageNamed:@"uncheck box.png"] forState:UIControlStateNormal];
    }
    else
    {
        checkMarkButtonClicked = YES;
        [checkMarkButton setBackgroundImage:[UIImage imageNamed:@"check box .png"] forState:UIControlStateNormal];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [super dealloc];
}

@end
