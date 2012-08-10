//
//  AppHeaderView.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "AppHeaderView.h"

@implementation AppHeaderView
@synthesize signOutButton;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        NSString *name = @"";
        [name stringByAppendingString:[NSString stringWithFormat:@"%@ %@",[global_userDetails objectForKey:@"FirstName"],[global_userDetails objectForKey:@"LastName"]]];
        
        headerBackgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
        headerBackgroundImageView.image = [UIImage imageNamed:@"Header bg.png"];
        [self addSubview:headerBackgroundImageView];
        
        
        patientNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 200, 35)];
        patientNameLabel.textColor = [UIColor blackColor];
        patientNameLabel.text = name;
        patientNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:patientNameLabel];
        
      /*  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [NSDateFormatter setDefaultFormatterBehavior:NSDateFormatterBehavior10_4];
        [dateFormatter setDateFormat:@"MM/dd/YYYY"];
        NSString *selected = [dateFormatter stringFromDate:[NSDate date]];
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 5, 200, 35)];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.text = selected;
        dateLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:dateLabel];
        [dateFormatter release];*/
        
        
        someNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(700, 5, 200, 35)];
        someNameLabel.textColor = [UIColor blackColor];
        someNameLabel.text = @"";
        someNameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:someNameLabel];
        
        signOutButton = [[UIButton alloc] initWithFrame:CGRectMake(920, 5, 100, 35)];
        [signOutButton setBackgroundImage:[UIImage imageNamed:@"logout.png"] forState:UIControlStateNormal];
        [signOutButton setBackgroundImage:[UIImage imageNamed:@"logout-roll.png"] forState:UIControlStateSelected];
        [self addSubview:signOutButton];
        
  
        
       
    }
    return self;
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
