//
//  AppHeaderView.h
//  Medtec medical inc
//
//  Created by Saikumar Bondugula on 26/03/12.
//  Copyright 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppHeaderView : UIView 
{
    UIImageView *headerBackgroundImageView;
    UILabel  *patientNameLabel;
    UILabel  *dateLabel;
    UILabel  *someNameLabel;
    UIButton *signOutButton;

}
@property(nonatomic,assign)UIButton *signOutButton;

@end
