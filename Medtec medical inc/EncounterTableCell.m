//
//  EncounterTableCell.m
//  Medtec medical inc
//
//  Created by Deepika on 02/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "EncounterTableCell.h"

@implementation EncounterTableCell

@synthesize visitDate,providerName,visitCounter,encStatus,pSign,mdSign,messageFromBiller;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)dealloc
{
    [visitDate release];
    [providerName release];
    [visitCounter release];
    [encStatus release];
    [pSign release];
    [mdSign release];
    [messageFromBiller release];
    [super dealloc];
}

@end
