//
//  SWViewController.h
//  NiceExchange
//
//  Created by Spacewalk on 16/7/25.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SWViewController : UIViewController
@property (nonatomic ,strong)NSString *titleMessage;
@property (strong, nonatomic) IBOutlet UITextView *textViewL;

#warning  Blokc传值 第一步:声明Block

@property (nonatomic,copy) void(^SecondBlock)(SWComment *comment);

#warning 00000000000000000000
@property (nonatomic,strong)SWComment *comment;

@end
