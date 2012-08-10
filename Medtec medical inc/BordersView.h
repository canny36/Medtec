//
//  BordersView.h
//  MiracleBaby
//
//  Created by Logictreeit4 on 24/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BordersView : NSObject 
{
     CALayer *l;
}

+ (BordersView *)sharedDataSource;
-(void)addlayerToTextField:(UITextField *)textField;
-(void)addlayerToButton:(UIButton *)button;
-(void)addlayerToTextView:(UITextView *)textView;

@end
