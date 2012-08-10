//
//  BordersView.m
//  MiracleBaby
//
//  Created by Logictreeit4 on 24/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BordersView.h"


@implementation BordersView

static BordersView *sharedDataSource = nil;
+ (BordersView *)sharedDataSource {
	//static DataSource *sharedDataSource = nil;
	//@synchronized( sharedDataSource ) {
	if (sharedDataSource == nil) {
		sharedDataSource = [[BordersView alloc] init];
	}
	//}
	return sharedDataSource;
}

-(void)addlayerToButton:(UIButton *)button
{
    l = [button layer];
	[l setMasksToBounds:YES];
	[l setCornerRadius:3.0];
	[l setBorderWidth:1.50f];
	[l setBorderColor:[[UIColor colorWithRed:0.0/255 green:128.0/255 blue:128.0/255 alpha:1.0]CGColor]];
    
}

-(void)addlayerToTextField:(UITextField *)textField
{
	l = [textField layer];
	[l setMasksToBounds:YES];
	[l setCornerRadius:3.0];
	[l setBorderWidth:1.50f];
	[l setBorderColor:[[UIColor colorWithRed:7.0/255 green:65.0f/255 blue:83.0/255 alpha:1.0]CGColor]];
    textField.backgroundColor = [UIColor whiteColor];
}

-(void)addlayerToTextView:(UITextView *)textView
{
    l = [textView layer];
	[l setMasksToBounds:YES];
	[l setCornerRadius:3.0];
	[l setBorderWidth:1.50f];
	[l setBorderColor:[[UIColor colorWithRed:0.0/255 green:128.0/255 blue:128.0/255 alpha:1.0]CGColor]]; 
}

@end
