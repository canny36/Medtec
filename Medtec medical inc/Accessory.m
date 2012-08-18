//
//  Accessory.m
//  Medtec medical inc
//
//  Created by Logic2 on 16/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import "Accessory.h"

@interface Accessory()

@property(nonatomic,retain,readwrite) NSString *equipName;
@property(nonatomic,retain,readwrite)NSString *manufacturer;
@property(nonatomic,retain,readwrite)NSString *part;
@property(nonatomic,retain,readwrite)NSString *accessoryName;

-(void)initVars:(NSDictionary*)dict;
-(id)getValue:(NSString*)key:(NSDictionary*)bundle;

@end

@implementation Accessory


@synthesize equipName,part,quantity,accessoryCount,accessoryID,manufacturer,accessoryName;

- (id)initWithDict:(NSDictionary*)dict {
    self = [super init];
    if (self) {
        [self initVars:dict];
    }
    return self;
}


-(void)initVars:(NSDictionary*)dict{
    //    "EquipID": 5,
    //    "AccessoryID": 17,
    //    "PracticeID": 1,
    //    "Equip_Name": "Surgical Lights",
    //    "Manufacturer": "Docman Laboratories Pvt. Ltd.   ",
    //    "Model": "99292",
    //    "Quantity": 8,
    //    "QuantityonHand": 9,
    //    "StatusID": 1,
    //    "PartNumber": "1",
    //    "SupplyQuantity": 27,
    //    "AccQtyOnHand": 20,
    //    "AccManufacturer": "test manuf",
    //    "AccStatusID": 1,
    //    "AccessoryCount": 0
    
    self.equipName = [self getValue:@"Equip_Name" :dict];
    self.manufacturer= [self getValue:@"Manufacturer" :dict];
    self.accessoryCount = [[self getValue:@"AccessoryCount" :dict] intValue];
    self.accessoryID = [[self getValue:@"AccessoryID" :dict] intValue];
    self.quantity = [[self getValue:@"Quantity" :dict] intValue];
    self.part = [self getValue:@"PartNumber" :dict];
    self.accessoryName = [self getValue:@"AccessoryName" :dict];
}


-(id)getValue:(NSString*)key:(NSDictionary*)bundle{
    
    id value = [bundle objectForKey:key];
    if (value != nil && value != [NSNull null]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            value = [NSString stringWithFormat:@"%d",[value intValue]];
        }
        return value;
    }
    return @""; 
}


+(NSMutableArray*)collection:(id)result{
    
    NSMutableArray *collection = [[NSMutableArray alloc]init];
    
    if ([result isKindOfClass:[NSArray class]]) {
        int count = ((NSArray*)result).count;
        for (int i=0; i<count; i++) {
            NSDictionary *dict = [result objectAtIndex:i];
            Accessory *accessory = [[Accessory alloc]initWithDict:dict];
            [collection addObject:accessory];
            [accessory release];
        }
    }
    return collection;
}


@end
