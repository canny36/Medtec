//
//  LoginInfo.h
//  Medtec medical inc
//
//  Created by Logic2 on 12/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInfo : NSObject{



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

    
    NSString *description;
    NSString *firstName;
    NSString *lastName;
    NSString *middleName;
    NSString *password;
    int practiceID;
    int userId;
    NSString *userName;
    NSString *practiceUserType;
    NSString *practiceName;

}

@property(nonatomic,retain,readonly)NSString *description;
@property(nonatomic,retain,readonly)NSString *firstName;
@property(nonatomic,retain,readonly)NSString *lastName;
@property(nonatomic,retain,readonly)NSString *middleName;
@property(nonatomic,retain,readonly)NSString *password;
@property(readonly)int practiceID;
@property(readonly)int userId;
@property(nonatomic,retain,readonly)NSString *userName;
@property(nonatomic,retain,readonly)NSString *practiceUserType;
@property(nonatomic,retain,readonly)NSString *practiceName;

- (id)initWithDictionary:(NSDictionary*)dict;

@end
