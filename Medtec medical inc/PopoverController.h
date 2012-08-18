//
//  PopoverController.h
//  Medtec medical inc
//
//  Created by Logic2 on 11/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopupDelegate
@required
-(void)didSelectRow:(int)row;

@end

@interface PopoverController : UITableViewController<UITableViewDelegate,UITableViewDataSource>{
    
    
    NSArray *array;
    id<PopupDelegate> delegate;
}

@property(nonatomic,retain)NSArray *array;
@property(nonatomic,assign)id<PopupDelegate> delegate;

@end
