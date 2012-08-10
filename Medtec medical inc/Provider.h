//
//  Provider.h
//  Medtec medical inc
//
//  Created by Logic2 on 07/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Provider : NSObject


//Email = "Zalzaleh@medtecp3.com";
//FirstName = Zalzaleh;
//FullName = "Zalzaleh  ";
//LastName = " ";
//MiddleName = " ";
//NPI = 1992704035;
//Password = 123456;
//PhoneNumber = 7084249710;
//PracticeID = 1;
//PracticeUserType = Provider;
//StatusID = 1;
//UserID = 7;
//UserName = Zalzaleh;

{
    NSString *email;
    NSString *firstName;
    NSString *fullName;
    NSString *lastName;
    NSString *middleName;
    
    int npi;
    int password;
    int phoneNo;
    int practiceId;
    int statusId;
    int userId;
    
    NSString *practiceUserType;
    NSString *userName;
    
    
}

@property(nonatomic,retain)NSString *email;
@property(nonatomic,retain)NSString *firstName;
@property(nonatomic,retain)NSString *fullName;
@property(nonatomic,retain)NSString *lastName;
@property(nonatomic,retain)NSString *middleName;
@property(nonatomic,retain)NSString *practiceUserType;
@property(nonatomic,retain)NSString *userName;
@property int npi;
@property int password;
@property int phoneNo;
@property int practiceId;
@property int statusId;
@property int userId;

@end
