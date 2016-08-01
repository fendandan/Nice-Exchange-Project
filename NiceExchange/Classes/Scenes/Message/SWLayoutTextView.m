//
//  SWLayoutTextView.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/19.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWLayoutTextView.h"

#define textViewFont [UIFont systemFontOfSize:18]//字体大小
static CGFloat leftFloat = 5.0f;
static CGFloat sendBtnW = 30.0f;
static CGFloat sendBtnH = 40.0f;

@interface SWLayoutTextView ()
<
UITextViewDelegate
>

@property (assign, nonatomic) CGFloat superHight;
@property (assign, nonatomic) CGFloat textViewY;
@property (assign, nonatomic) CGFloat sendButtonOffset;
@property (assign, nonatomic) CGFloat keyBoardHight;
@property (assign, nonatomic) CGRect originalFrame;
@end
@implementation SWLayoutTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addTextView];
        
    }
    return self;
    
}
    -(void)addTextView
    {
        
        
        self.textView.backgroundColor = [UIColor cyanColor];
        UITextView *textView = [[UITextView alloc] init];
        //textView.delegate   = self;
        textView.textColor   = [UIColor grayColor];
        textView.backgroundColor = [UIColor whiteColor];
        textView.font = textViewFont;
        textView.layer.cornerRadius  = 5;
        textView.layer.masksToBounds = YES;
        textView.layer.borderWidth   = 0.5;
        textView.layer.borderColor   = [[UIColor grayColor] CGColor];
        textView.layoutManager.allowsNonContiguousLayout = NO;
        [self addSubview:textView];
        self.textView= textView;
        
        CGFloat textViewX = leftFloat;
        CGFloat textViewW = kScreenWidth-(3*textViewX+sendBtnW)+leftFloat;
        CGFloat textViewH = kSelfHeight;
        CGFloat textViewY = (self.frame.size.height-textViewH)*0.5;
        _textView.frame = CGRectMake(0, 0,textViewW , textViewH);
        
        
        self.textViewY = textViewY;
        _sendButtonOffset = (self.frame.size.height-sendBtnH)*0.5;
        _superHight = self.frame.size.height;
        
        self.textView.layer.masksToBounds = YES;
        self.textView.layer.cornerRadius = self.textView.bounds.size.height/6;
        self.textView.alpha = 0.8;
    }
//字体颜色
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text  isEqual: self.placeholder]) {
        self.textView.text = @"";
    }
    
    self.textView.textColor = [UIColor purpleColor];
    }

- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    _textView.text = _placeholder;
}
-(void)textViewDidChange:(UITextView *)textView
{
    CGRect frame = textView.frame;
    CGSize constraintSize = CGSizeMake(frame.size.width, MAXFLOAT);
    CGSize size = [textView sizeThatFits:constraintSize];
    if (size.height < 100) {
        size.height = 100;
    }else
    {
        if (size.height > 300 ) {
            size.height = 300;
            textView.scrollEnabled = YES;// 允许滚动
        }
        else
        {
            textView.scrollEnabled = NO;// 不允许滚动
        }
    }
    
    textView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, size.height);
    if (_delegate) {
        [_delegate changeLayoutView];
    }
    
    
}

@end
