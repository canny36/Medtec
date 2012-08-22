//
//  RadioButton.h
//  Medtec medical inc
//
//  Created by Logic2 on 21/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadioButton : UIView{
    
    NSString *text;
    BOOL selected;
    
    UIImageView *radioView;
    UILabel *label;
    
}

@property(nonatomic)BOOL selected;
@property(nonatomic , retain)NSString *text;

@end
