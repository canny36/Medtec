//
//  InsuranceView.h
//  Medtec medical inc
//
//  Created by Logic2 on 13/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol InsuranceDelegate<NSObject>

@required

-(void)onRemoveInsurance:(id)view;

@end

@interface InsuranceView : UIView{
    
    BOOL isDependent;
    id<InsuranceDelegate> delegate;
    
    UITextField *insuranceIdField;
     UITextField *subscriberNameField;
     UITextField *relationshipField;
    
}

@property(nonatomic,assign) BOOL isDependent;
@property(nonatomic,assign)id delegate;

@property(nonatomic , retain)UITextField *insuranceIdField;
@property(nonatomic , retain)UITextField *subscriberNameField;;
@property(nonatomic , retain)UITextField *relationshipField;

- (id)initWithFrame:(CGRect)frame withRemove :(BOOL)withRemove isDependent : (BOOL)_isDependent;




@end
