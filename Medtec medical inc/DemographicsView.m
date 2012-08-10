//
//  DemographicsView.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 27/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "DemographicsView.h"


@implementation DemographicsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"demographics.png"]];
               
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(750, 5, 300, 30)];
        titleLabel.text = @"Patient Demographics";
        titleLabel.textColor = [UIColor blueColor];
        titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
        titleLabel.textAlignment = UITextAlignmentCenter;
        titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:titleLabel];
        
        
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
