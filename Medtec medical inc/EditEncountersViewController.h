//
//  EditEncountersViewController.h
//  Medtec medical inc
//
//  Created by Deepika on 28/07/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppHeaderView;
@interface EditEncountersViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UIScrollView *scrollView;
    AppHeaderView *appHeaderView;
    IBOutlet UITableView *accessoryTable;
    IBOutlet UITableView *encounterListTable;
}

@end
