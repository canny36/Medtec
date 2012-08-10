//
//  CaptureSignatureViewController.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 28/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AppHeaderView;
@interface CaptureSignatureViewController : UIViewController
{
    AppHeaderView     *appHeaderView;
    
    
    IBOutlet UIImageView *drawImage;
	int mouseMoved;
	BOOL mouseSwiped;
	CGPoint lastPoint;
	IBOutlet UIToolbar *toolBar;

    
}
-(void)signOutButtonClicked;

@property (nonatomic, retain) UIImageView *drawImage;
//@property (nonatomic , assign)int cur_option;
-(UIImage*)scaleImage:(UIImage*)image  scaledToSize:(CGSize)newSize;
@end
