//
//  Accessory.h
//  Medtec medical inc
//
//  Created by Logic2 on 16/08/12.
//  Copyright (c) 2012 LogicTree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Accessory : NSObject{
    
    
    
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
    
    NSString *equipName;
     int quantity;
    NSString *manufacturer;
    NSString *part;
    int accessoryID;
    int accessoryCount;
    NSString *accessoryName;
  
}

@property(nonatomic,retain,readonly) NSString *equipName;
@property int quantity;
@property(nonatomic,retain,readonly)NSString *manufacturer;
@property(nonatomic,retain,readonly)NSString *part;
@property(nonatomic,retain,readonly)NSString *accessoryName;
@property int accessoryID;
@property int accessoryCount;

+(NSMutableArray*)collection:(id)result;

@end
