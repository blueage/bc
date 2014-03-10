//
//  lowooPhoneBookViewController.m
//  banana_clock
//
//  Created by MAC on 13-6-3.
//  Copyright (c) 2013年 MAC. All rights reserved.
//

#import "lowooPhoneBookViewController.h"
#import "GTMBase64.h"
#import "phoneNumberCell.h"



@implementation lowooPhoneBookViewController


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initNavigationBar];
    self.stringTitle = @"PHONE BOOK";
    [self changeTitle];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(transferPhoneBookNumber:) name:@"transferPhoneBookNumber" object:nil];
        
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mutableArrayPhoneBook = [[NSMutableArray alloc] init];

    if ([[UIDevice currentDevice].model isEqualToString:@"iPhone"]) {
        [self getPhoneBook];
    }else{
        //[liboTOOLS alertViewMSG:[BASE International:@"该设备不支持通讯录添加好友"]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"该设备不支持通讯录添加好友" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
    }
    
    
    [self.slimeView removeFromSuperview];
    [self transferPhoneBook];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initView{
    [self.tableView reloadData];
}

- (void)getPhoneBook{
    //通讯录
	//_addressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //dispatch_release(sema);/////////////////////
    }
    else{
        //_addressBook = ABAddressBookCreate();
    }
    
    _arrayPhoneBook = [[NSMutableArray alloc]init];
    _arrayPerson = ABAddressBookCopyArrayOfAllPeople(_addressBook);

    for (int i=0; i<CFArrayGetCount(_arrayPerson); i++) {
        _person = CFArrayGetValueAtIndex(_arrayPerson, i);
        _name = (__bridge NSString*)ABRecordCopyCompositeName(_person);
        _personName = [_name stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        _phone = ABRecordCopyValue(_person, kABPersonPhoneProperty);
        _personphone = [(__bridge NSString*)ABMultiValueCopyValueAtIndex(_phone, 0) stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSDictionary *dictionary = [[NSDictionary alloc]initWithObjectsAndKeys:_personName, @"personName", _personphone, @"personPhone", nil];
        [_arrayPhoneBook insertObject:dictionary atIndex:i];
    }
}


- (void)transferPhoneBook{
    float phoneNum = (float)_arrayPhoneBook.count;
    _uptimes = ceil(phoneNum/10.0);
    for (int i=0; i<_uptimes; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int t=0; t<10; t++) {
            if ((t+i*10)<phoneNum) {
                NSString *number = [[_arrayPhoneBook objectAtIndex:t+i*10] objectForKey:@"personPhone"];
                if (number.length>11) {
                    number = [number substringWithRange:NSMakeRange(number.length-11, 11)];
                }
                if (number)[array addObject:number];
            }
        }
        [self.manager doHTTPRequestWithPostFields:[NSDictionary dictionaryWithObjectsAndKeys:array, @"phoneNumber", nil] requestType:transferPhoneBookNumber];
    }
}

- (void)transferPhoneBookNumber:(NSNotification *)sender{//libo-------- 返回格式错误
    if (![BASE isNotNull:sender.userInfo]) {
        return;
    }

    _uptimes --;
    //只显示app用户
    /**
     personName = "\U738b\U96e8\U8679\U73ed\U4efb";
     personPhone = 13552401817;
     */
    
    //取得绑定的好友的手机号，如果没有，暂不显示，（不能发送短信）
    if ([BASE isNotNull:[sender.userInfo objectForKey:@"list"]]) {
        for (int i=0; i<[[sender.userInfo objectForKey:@"list"] count]; i++) {
            NSDictionary *dictionary = [[sender.userInfo objectForKey:@"list"] objectAtIndex:i];
            NSString *phoneNumber = [dictionary objectForKey:@"tel"];
            NSString *fid = [dictionary objectForKey:@"username"];
            //生成带 姓名 好友username的字典
            NSMutableDictionary *multbleDictionary = [[NSMutableDictionary alloc] init];
            for (NSDictionary *dict in _arrayPhoneBook) {
                if ([phoneNumber isEqualToString:[dict objectForKey:@"personPhone"]]) {
                    multbleDictionary = [NSMutableDictionary dictionaryWithDictionary:dict];
                    break;
                }
            }
            [multbleDictionary setObject:fid forKey:@"fid"];
            
            [_mutableArrayPhoneBook insertObject:multbleDictionary atIndex:0];
            //动画插入
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
        }
    }
    if (_uptimes == 0) {
        if (_mutableArrayPhoneBook.count == 0) {
            if (LANGUAGE_CHINESE) {
                //[liboTOOLS alertViewMSG:@"通讯录中的好友还没有绑定他们的手机号，请使用其他方式添加好友"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"通讯录中的好友还没有绑定他们的手机号，请使用其他方式添加好友" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
                [alertView show];
            }else {
                //[liboTOOLS alertViewMSG:@"Contacts friend has not bound to their mobile phone number, please use other ways to add friends"];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Contacts friend has not bound to their mobile phone number, please use other ways to add friends" delegate:self cancelButtonTitle:@"好" otherButtonTitles: nil];
                [alertView show];
            }
            
        }
    }
}


- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mutableArrayPhoneBook.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier=@"cellIdentifier";
    phoneNumberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        cell=[[phoneNumberCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }

    [cell confirmData:[_mutableArrayPhoneBook objectAtIndex:indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}



#pragma mark----------- 发短信 ----------
- (void)sendMessageTo:(NSArray *)array{
    BOOL canSendSMS = [MFMessageComposeViewController canSendText];
    if (canSendSMS) {
        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
        picker.messageComposeDelegate = self;
        picker.navigationBar.tintColor = [UIColor blackColor];
        picker.body = @"bananaClock";
       // picker.recipients = [NSArray arrayWithObject:@"186-1087-7557"];
        picker.recipients = array;
//        [self presentModalViewController:picker animated:YES];
        
    }else{
       [liboTOOLS alertViewMSG:[BASE International:@"设备不支持发送短信"]];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    switch (result) {
        case MessageComposeResultCancelled:
            
            break;
        case MessageComposeResultSent:
            [liboTOOLS alertViewMSG:[BASE International:@"信息已发送"]];
            break;
        case MessageComposeResultFailed:
            
            break;
        default:
            break;
    }
//    [self dismissModalViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}


@end
