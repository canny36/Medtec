//
//  Provider.m
//  Medtec medical inc
//
//  Created by Logic2 on 07/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Provider.h"

@implementation Provider
@synthesize email,firstName,fullName,lastName,middleName,npi,password,phoneNo,practiceId,practiceUserType,statusId,userId,userName;

-(void)dealloc
{
    [email release];
    [firstName release];
    [fullName release];
    [lastName release];
    [middleName release];
    [practiceUserType release];
    [userName release];
}

@end
