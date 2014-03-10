//
//  lowooPhoneBookViewController.h
//  banana_clock
//
//  Created by MAC on 13-6-3.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooBaseVC.h"
#import <MessageUI/MessageUI.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface lowooPhoneBookViewController : lowooBaseVC<MFMessageComposeViewControllerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *arrayPhoneBook;
@property (nonatomic, strong) NSMutableArray *mutableArrayPhoneBook;
@property (nonatomic, strong) NSString *selfPhoneNumer;
@property (nonatomic, assign) NSInteger uptimes;


@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *personphone;
@property (nonatomic, strong) NSString *personName;
@property (nonatomic) CFArrayRef arrayPerson;
@property (nonatomic) ABMultiValueRef phone;
@property (nonatomic) ABRecordRef person;
@property (nonatomic) ABAddressBookRef addressBook;

@end
