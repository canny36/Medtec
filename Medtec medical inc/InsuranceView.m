//
//  InsuranceView.m
//  Medtec medical inc
//
//  Created by Logic2 on 13/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "InsuranceView.h"
#import "RadioButton.h"

@interface InsuranceView()

-(void)loadViews:(CGRect)frame:(BOOL)hasRemove;
-(void)remove:(id)sender;
@end

@implementation InsuranceView

@synthesize isDependent;
@synthesize delegate;
@synthesize subscriberNameField;
@synthesize insuranceIdField;
@synthesize relationshipField;
@synthesize insuranceNameField;

- (id)initWithFrame:(CGRect)frame withRemove :(BOOL)withRemove isDependent : (BOOL)_isDependent
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.isDependent = _isDependent;
        [self loadViews:frame:withRemove];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews:frame:NO];
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


-(void)remove:(id)sender{
    
    NSLog(@"Remove selector out ");
    
    if ([sender isKindOfClass:[UIButton class]]) {
        NSLog(@"Remove selector ");
        
//        [self removeFromSuperview];
        [delegate onRemoveInsurance:self];

    }
}

-(void)loadViews:(CGRect)_frame:(BOOL)hasRemove{
    
    _frame = self.frame;
    CGFloat y = 0;
    y = 10;
    
    
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"Insurance Type :";
    label.frame = CGRectMake(0, y + 10, 146, 40);
   
    label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label.backgroundColor=[UIColor clearColor];   
    [self addSubview:label];
    [label release];
    
    RadioButton *radio = [[RadioButton alloc]initWithFrame:CGRectMake(150, y+10, 200,40)];
    [self addSubview:radio];

    
    if (hasRemove) {
        UIButton *btn= [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
        btn.frame = CGRectMake(300 + 10 , y + 10, 90, 30);
        btn.backgroundColor = [UIColor clearColor];
        [btn setTitle:@"remove" forState:UIControlStateNormal];
        btn.alpha = 1.0;
        [btn addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn]; 
        [btn release];
    }
    
       y = label.frame.origin.y + 40 ;
    
    //// insurance name 
    
   label = [[UILabel alloc]init];
    label.text = @"Insurance Name :";
    label.frame = CGRectMake(0, y + 10, 146, 31);
    
    label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label.backgroundColor=[UIColor clearColor];   
    [self addSubview:label];
    [label release];
    
    
    
    insuranceNameField = [[UITextField alloc]init];
    insuranceNameField.frame = CGRectMake(150, y+10, 176, 31);
    
    [insuranceNameField setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:insuranceNameField];
    
    
    y = label.frame.origin.y + 31 ;
    
    /// INSURANCE ID
     
    label = [[UILabel alloc]init];
    label.text = @"Insurance Id :";
    label.frame = CGRectMake(0, y + 10, 146, 31);
 
         label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
    label.backgroundColor=[UIColor clearColor];   
    [self addSubview:label];
    [label release];
    
    
    insuranceIdField = [[UITextField alloc]init];
    insuranceIdField.frame = CGRectMake(150, y+10, 176, 31);
    
    [insuranceIdField setBorderStyle:UITextBorderStyleRoundedRect];
    [self addSubview:insuranceIdField];
    
       y = label.frame.origin.y + 31;
    
    // SUBSCRIBER 
    
    if (isDependent) {
        
        label = [[UILabel alloc]init];
        label.text = @"Subcriber Name :";
        label.frame = CGRectMake(0, y+15 , 146, 31);
                
             label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        [label release];
        
        
        
        subscriberNameField = [[UITextField alloc]init];
        subscriberNameField.frame = CGRectMake(150, y+15, 176, 31);
        y = subscriberNameField.frame.origin.y + 31;
        [subscriberNameField setBorderStyle:UITextBorderStyleRoundedRect];
        
        [self addSubview:subscriberNameField];
        ;
        
        y = label.frame.origin.y + 31 ;

        
        
        
        label = [[UILabel alloc]init];
        label.text = @"Relationship :";
        label.frame = CGRectMake(0, y+15 , 146, 31);
      
        label.font =  [UIFont fontWithName:@"Helvetica-Bold" size:16.0];
        label.backgroundColor=[UIColor clearColor];
        [self addSubview:label];
        [label release];
        
        
        relationshipField = [[UITextField alloc]init];
        relationshipField.tag = 200;
        [relationshipField setBorderStyle:UITextBorderStyleRoundedRect];
        
        relationshipField.frame = CGRectMake(150, y+15, 176, 31);
        y = relationshipField.frame.origin.y + 31;
        [self addSubview:relationshipField];
        
          y = label.frame.origin.y + 31 ;

    }
    


}

- (void)dealloc {
    [relationshipField release];
    [subscriberNameField release];
    [insuranceIdField release];
    [super dealloc];
}
@end
