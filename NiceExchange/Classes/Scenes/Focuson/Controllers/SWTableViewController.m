//
//  SWTableViewController.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/18.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWTableViewController.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <UIKit/UINavigationController.h>
#import <AddressBook/ABAddressBook.h>
#import <AddressBook/ABMultiValue.h>
#import <AddressBook/ABRecord.h>
#import "TKAddressBook.h"
#import "SWCommentsTableViewCell.h"
#import <MessageUI/MessageUI.h>

@interface SWTableViewController ()<MFMessageComposeViewControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic ,strong)NSMutableArray *addressBookTemp;
@end

@implementation SWTableViewController

//发送短信的方法
 -(void)sendMessage
{
       //用于判断是否有发送短信的功能（模拟器上就没有短信功能）
       Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
   
        //判断是否有短信功能
    if (messageClass != nil) {
               //有发送功能要做的事情
            }
     else
           {
         
                    UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"iOS版本过低（iOS4.0以后）" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
            
                   [alterView show];
                }

    
    //有短信功能
            if ([messageClass canSendText]) {
                    //发送短信
               }
          else
               {
                       UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该设备没有发送短信的功能~" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
         
                       [alterView show];
               }
  
    
//    
//    //实例化MFMessageComposeViewController,并设置委托
//               MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
//                messageController.delegate = self;
//   
//    
//               //拼接并设置短信内容
//                NSString *messageContent = [NSString stringWithFormat:@"2222222222"];
//              messageController.body = messageContent;
//   
//                //设置发送给谁
//    messageController.recipients = @[@"11"];
//   
//               //推到发送试图控制器
//               [self presentViewController:messageController animated:YES completion:^{
//                   
//                    }];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image.png"]];

    _addressBookTemp = [NSMutableArray array];



    //新建一个通讯录类
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
       
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);



    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        TKAddressBook *addressBook = [[TKAddressBook alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        [_addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _addressBookTemp.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"ContactCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    TKAddressBook *book = [_addressBookTemp objectAtIndex:indexPath.row];
    
    cell.textLabel.text = book.name;
    
    cell.detailTextLabel.text = book.tel;
    cell.selectionStyle = UITableViewCellAccessoryNone;
    
    UIButton  *invitation = [UIButton buttonWithType:UIButtonTypeCustom];
    invitation.backgroundColor = [UIColor cyanColor];
    invitation.frame = CGRectMake(300 , 10, 60, 40);
    [invitation setImage:[UIImage imageNamed:@"已收藏.png"] forState:(UIControlStateNormal)];
    [invitation addTarget:self action:@selector(photographButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    invitation.tag = indexPath.row;
    invitation.highlighted = YES;
    [cell.contentView addSubview:invitation];
    
    return cell;
   
}
- (void)photographButtonClicked:(UIButton *)sender{
    NSLog(@"发短信");
    
    [self sendMessage];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60;
}


//发送短信后回调的方法
 -(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
 {
         NSString *tipContent;
         switch (result) {
                     case MessageComposeResultCancelled:
                        tipContent = @"发送短信已";
                        break;
        
                     case MessageComposeResultFailed:
                        tipContent = @"发送短信失败";
                        break;
            
                     case MessageComposeResultSent:
                         tipContent = @"发送成功";
                         break;
            
                     default:
                         break;
             }
    
         UIAlertView *alterView = [[UIAlertView alloc] initWithTitle:@"提示" message:tipContent delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
         [alterView show];
     }
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
