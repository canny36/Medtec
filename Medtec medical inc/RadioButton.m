//
//  RadioButton.m
//  Medtec medical inc
//
//  Created by Logic2 on 21/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "RadioButton.h"

#define RADIO_OFF @"btn_radio_off_holo_light.png"
#define RADIO_ON @"btn_radio_on_holo_light.png"


@interface RadioButton()

-(void)loadView;
@end

@implementation RadioButton

@synthesize selected;
@synthesize text;

static UIImage *onImage ;
static UIImage *offImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        onImage = [UIImage imageNamed:RADIO_ON];
        offImage = [UIImage imageNamed:RADIO_OFF];
        self.clipsToBounds = YES;
        [self loadView];
        
        
    }
    return self;
}


-(void)loadView{
    
  CGFloat width =  [onImage size].width;
    CGFloat height = [onImage size].height;
    
    radioView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, width ,height )];
    [radioView setImage:offImage];
    
    [self addSubview:radioView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(width + 4, 0 , 200, self.frame.size.height)];
    label.font =  [UIFont fontWithName:@"Helvetica" size:16.0];
    label.backgroundColor=[UIColor clearColor];  
    label.text = @"Radiobutton";
    [self addSubview:label];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@" Touches began");
    selected = !selected;
    [radioView setImage:selected == YES ? onImage : offImage];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
