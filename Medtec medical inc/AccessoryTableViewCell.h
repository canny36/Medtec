//
//  AccessoryTableViewCell.h
//  Medtec medical inc
//
//  Created by Deepika on 03/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccessoryTableViewCell : UITableViewCell
{
    IBOutlet UIButton *accessoryButton;
    IBOutlet UILabel *accessoryName;
    IBOutlet UILabel *quantity;
    IBOutlet UILabel *manufacturer;
    IBOutlet UILabel *part;
}

@property(nonatomic,retain)UIButton *accessoryButton;
@property(nonatomic,retain)UILabel *accessoryName;
@property(nonatomic,retain)UILabel *quantity;
@property(nonatomic,retain)UILabel *manufacturer;
@property(nonatomic,retain)UILabel *part;

@end
