//
//  SWLayoutTextView.h
//  NiceExchange
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "BaseView.h"



@protocol SwLayoutTextViewDelegate <NSObject>
-(void)changeLayoutView;
@end
@interface SWLayoutTextView : BaseView
@property (strong, nonatomic) UITextView *textView;
@property (copy, nonatomic) NSString *placeholder;
@property (weak ,nonatomic) id <SwLayoutTextViewDelegate> delegates;

@end
