//
//  SignatureView.h
//  Medtec medical inc
//
//  Created by Logic2 on 10/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignatureView : UIView
{
    
    UIImageView *signatureCaptureImageView;   
    UILabel *sigTitle;
    UIButton *clearBtn;
    UIButton *doneBtn;
    int mouseMoved;
	BOOL mouseSwiped;
	CGPoint lastPoint;
}


@end
