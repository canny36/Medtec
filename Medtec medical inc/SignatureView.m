//
//  SignatureView.m
//  Medtec medical inc
//
//  Created by Logic2 on 10/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "SignatureView.h"

@implementation SignatureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[UIColor grayColor];
        
        sigTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
        sigTitle.backgroundColor=[UIColor darkGrayColor];
        sigTitle.textAlignment=UITextAlignmentCenter;
        sigTitle.text=@"Patient Signature";
        sigTitle.font=[UIFont boldSystemFontOfSize:18];
        sigTitle.textColor=[UIColor whiteColor];
        [self addSubview:sigTitle];
         
        signatureCaptureImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 90, self.frame.size.width-20, self.frame.size.height-150)];
        signatureCaptureImageView.backgroundColor = [UIColor whiteColor];
        signatureCaptureImageView.userInteractionEnabled=YES;        
        [self addSubview:signatureCaptureImageView];
        
        clearBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        ;
        clearBtn.frame=CGRectMake(60, signatureCaptureImageView.frame.size.height+100, 72, 37);
        [clearBtn setTitle:@"Clear" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearSignature) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:clearBtn];
        
        
        doneBtn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            doneBtn.frame=CGRectMake(280, signatureCaptureImageView.frame.size.height+100, 72, 37);
        [doneBtn setTitle:@"Done" forState:UIControlStateNormal];
        [doneBtn addTarget:self action:@selector(sendSignature) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:doneBtn];
          
        
    }
    return self;
}


-(void)clearSignature
{
    
    NSLog(@"Clear signature");
    signatureCaptureImageView.image=nil;
}


-(void)sendSignature
{
     NSLog(@"Send signature");
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self];
	//currentPoint.y -= 5; 
	
	if ([touch tapCount] == 2) {
		return;
	}	
	if(!mouseSwiped) 
	{
		
		UIGraphicsBeginImageContext(signatureCaptureImageView.frame.size);
		[signatureCaptureImageView.image drawInRect:CGRectMake(0, 0, signatureCaptureImageView.frame.size.width, signatureCaptureImageView.frame.size.height)]; //originally self.frame.size.width, self.frame.size.height)];
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);		
		CGContextBeginPath(UIGraphicsGetCurrentContext());
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		signatureCaptureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();	
		
	}
	
	lastPoint = [touch locationInView:self];
	//lastPoint.y -= 5;
	

}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    mouseSwiped = YES;
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self];
	//currentPoint.y -= 5; 
	
	UIGraphicsBeginImageContext(signatureCaptureImageView.frame.size);	
	[signatureCaptureImageView.image drawInRect:CGRectMake(0, 0, signatureCaptureImageView.frame.size.width, signatureCaptureImageView.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);	
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	signatureCaptureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}

    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self];
	//currentPoint.y -= 5; 
	
	if ([touch tapCount] == 2) {
		return;
	}		
	
	if(!mouseSwiped) {
		
		UIGraphicsBeginImageContext(signatureCaptureImageView.frame.size);
		[signatureCaptureImageView.image drawInRect:CGRectMake(0, 0, signatureCaptureImageView.frame.size.width, signatureCaptureImageView.frame.size.height)]; //originally self.frame.size.width, self.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);	
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
		CGContextBeginPath(UIGraphicsGetCurrentContext());
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		signatureCaptureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
	}	
	
}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
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
