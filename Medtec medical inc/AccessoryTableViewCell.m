//
//  AccessoryTableViewCell.m
//  Medtec medical inc
//
//  Created by Deepika on 03/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "AccessoryTableViewCell.h"

@implementation AccessoryTableViewCell
@synthesize accessoryButton,accessoryName,quantity,manufacturer,part;

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

}



-(void)dealloc
{
    [accessoryButton release];
    [accessoryName release];
    [quantity release];
    [manufacturer release];
    [part release];
    [super dealloc];
}

@end
