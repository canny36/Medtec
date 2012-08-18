//
//  LoginInfo.m
//  Medtec medical inc
//
//  Created by Logic2 on 12/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "LoginInfo.h"

@interface LoginInfo()

@property(nonatomic,retain,readwrite)NSString *description;
@property(nonatomic,retain,readwrite)NSString *firstName;
@property(nonatomic,retain,readwrite)NSString *lastName;
@property(nonatomic,retain,readwrite)NSString *middleName;
@property(nonatomic,retain,readwrite)NSString *password;
@property(readwrite)NSUInteger practiceID;
@property(readwrite)NSUInteger userId;
@property(nonatomic,retain,readwrite)NSString *userName;
@property(nonatomic,retain,readwrite)NSString *practiceUserType;
@property(nonatomic,retain,readwrite)NSString *practiceName;

-(void)initvars:(NSDictionary*)dict;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;

@end

@implementation LoginInfo

@synthesize firstName;
@synthesize lastName;
@synthesize middleName;
@synthesize practiceUserType;
@synthesize practiceID;
@synthesize userId;
@synthesize userName;
@synthesize password;
@synthesize practiceName;
@synthesize description;

- (id)initWithDictionary:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        [self initvars:dict];
    }
    return self;
}


-(void)initvars:(NSDictionary*)dict{
    
    //Description = "Apolo Hospital";
    //FirstName = Logictree;
    //LastName = IT;
    //MiddleName = Solutions;
    //Password = 123456;
    //PracticeID = 1;
    //PracticeName = Apolo;
    //PracticeUserType = Admin;
    //UserID = 3;
    //UserName = ltadmin;
    
    self.description = [self getValue:@"Description" :dict];
    self.userId = [[self getValue:@"UserID" :dict] intValue];
    self.userName = [self getValue:@"UserName" :dict];
    self.password = [self getValue:@"Password" :dict];
    self.practiceID = [[self getValue:@"PracticeID" :dict] intValue];
    self.practiceName = [self getValue:@"PracticeName" :dict];
    self.practiceUserType = [self getValue:@"PracticeUserType" :dict];
    
    self.firstName = [self getValue:@"FirstName" :dict];
    self.middleName = [self getValue:@"MiddleName" :dict];
     self.lastName = [self getValue:@"LastName" :dict];
    
}


-(id)getValue:(NSString*)key:(NSDictionary*)bundle{
    
    id value = [bundle objectForKey:key];
    if (value != nil && value != [NSNull null]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%d",[value intValue]];
        }
        return value;
    }
    return value; 
}
@end
