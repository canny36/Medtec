//
//  CaptureSignatureViewController.m
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import "CaptureSignatureViewController.h"
#import "AppHeaderView.h"
#import <QuartzCore/QuartzCore.h>
@implementation CaptureSignatureViewController
@synthesize drawImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)signOutButtonClicked
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20; 
	
	if ([touch tapCount] == 2) {
		return;
	}	
	if(!mouseSwiped) 
	{
		
		UIGraphicsBeginImageContext(self.drawImage.frame.size);
		[drawImage.image drawInRect:CGRectMake(0, 0, drawImage.frame.size.width, drawImage.frame.size.height)]; //originally self.frame.size.width, self.frame.size.height)];
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
		CGContextBeginPath(UIGraphicsGetCurrentContext());
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();	
		
	}
	
	lastPoint = [touch locationInView:self.view];
	lastPoint.y -= 20;
	
	
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	
	mouseSwiped = YES;
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20; 
	
	UIGraphicsBeginImageContext(self.drawImage.frame.size);	
	[drawImage.image drawInRect:CGRectMake(0, 0, drawImage.frame.size.width, drawImage.frame.size.height)];
	CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
	CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
	CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
	CGContextBeginPath(UIGraphicsGetCurrentContext());
	CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
	CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
	CGContextStrokePath(UIGraphicsGetCurrentContext());
	drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	lastPoint = currentPoint;
	mouseMoved++;
	
	if (mouseMoved == 10) {
		mouseMoved = 0;
	}
	
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPoint = [touch locationInView:self.view];
	currentPoint.y -= 20; 
	
	if ([touch tapCount] == 2) {
		return;
	}		
	
	if(!mouseSwiped) {
		
		UIGraphicsBeginImageContext(self.drawImage.frame.size);
		[drawImage.image drawInRect:CGRectMake(0, 0, drawImage.frame.size.width, drawImage.frame.size.height)]; //originally self.frame.size.width, self.frame.size.height)];
		CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
		CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0);
		CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0, 1.0, 1.0, 1.0);
		CGContextBeginPath(UIGraphicsGetCurrentContext());
		CGContextMoveToPoint(UIGraphicsGetCurrentContext(), lastPoint.x, lastPoint.y);
		CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
		CGContextStrokePath(UIGraphicsGetCurrentContext());
		drawImage.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
		
	}	
	
}
-(void)saveButtonClicked
{	
	//From android,Image density=72,image width=3,image height=1 
	//For iPhone CGSizeMake :image width=Image density*image width, image heigth=Image density*image height
//	CellTrakAppDelegate  *appDelegate = (CellTrakAppDelegate*)[[UIApplication sharedApplication]delegate];
	if (drawImage.image !=nil)
	{
		//UIImage *image=[self scaleImage:drawImage.image scaledToSize:CGSizeMake(216	,72)];	
//		appDelegate.signatureData =UIImagePNGRepresentation(image);	
//		appDelegate.sendVisit=1;
//		[self.navigationController popToViewController:[VisitDetailViewController shareController] animated:NO];
	}
	else
	{
//		appDelegate.signatureData =nil;
//		appDelegate.sendVisit=1;
//		[self.navigationController popToViewController:[VisitDetailViewController shareController] animated:NO];
	}
    
    
    //NSLog(@"current option = %d", cur_option);
    
}

-(void)cancelButtonClicked
{
    drawImage.image = nil;
    
}

-(UIImage*)scaleImage:(UIImage*)image  scaledToSize:(CGSize)newSize
{
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();	
	return newImage;
}




- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.hidesBackButton = YES;
    appHeaderView = [[AppHeaderView alloc] initWithFrame:CGRectMake(0, 0, 1024, 50)];
    [appHeaderView.signOutButton addTarget:self action:@selector(signOutButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:appHeaderView];
    
    
    
    /////////////////////////
    drawImage.userInteractionEnabled =	YES;
	mouseMoved = 0;
	
	UIBarButtonItem *saveButton=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"btn_send",@"") style:UIBarButtonItemStyleBordered target:self action:@selector(saveButtonClicked)];
    [saveButton setWidth:150];
	
    UIBarButtonItem *cancelButton=[[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"btn_clear",@"") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonClicked)];
	[cancelButton setWidth:150];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    NSArray *items = [NSArray arrayWithObjects:saveButton,flexItem,cancelButton, nil];
    [toolBar setItems:items animated:NO];	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (UIInterfaceOrientationIsLandscape(interfaceOrientation));
}

@end
