//
//  EncounterTableCell.h
//  Medtec medical inc
//
//  Created by Deepika on 02/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EncounterTableCell : UITableViewCell
{
    IBOutlet UILabel *visitDate;
    IBOutlet UILabel *providerName;
    IBOutlet UILabel *visitCounter;
    IBOutlet UILabel *encStatus;
    IBOutlet UILabel *pSign;
    IBOutlet UILabel *mdSign;
    IBOutlet UILabel *messageFromBiller;
}

@property(nonatomic,retain)UILabel *visitDate;
@property(nonatomic,retain)UILabel *providerName;
@property(nonatomic,retain)UILabel *visitCounter;
@property(nonatomic,retain)UILabel *encStatus;
@property(nonatomic,retain)UILabel *pSign;
@property(nonatomic,retain)UILabel *mdSign;
@property(nonatomic,retain)UILabel *messageFromBiller;

@end
