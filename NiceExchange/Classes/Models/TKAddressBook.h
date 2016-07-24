//
//  TKAddressBook.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseModel.h"



@interface TKAddressBook : BaseModel

{
    NSInteger sectionNumber;
    NSInteger recordID;
    NSString *name;
    NSString *email;
    NSString *tel;

}

@property NSInteger sectionNumber;
@property NSInteger recordID;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *email;
@property (nonatomic, retain) NSString *tel;

@end