//
//  SWAddRule.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWAddRule.h"

@implementation SWAddRule

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addRule];
    }
    return self;
}
-(void)addRule{
    //self.backgroundColor = [UIColor cyanColor];
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame =  CGRectMake(80,10,100, 30);
    butt.layer.masksToBounds = YES;
    butt.layer.cornerRadius = butt.frame.size.height/4;
    butt.backgroundColor = [UIColor orangeColor];
    [butt setTitle:@"大家聊聊" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.button = butt;
    [self addSubview:self.button];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(CGRectGetMaxX(butt.frame) + 10, 10, 100, 30);
    btn.backgroundColor = [UIColor orangeColor];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = butt.frame.size.height/4;
    [btn setTitle:@"尽管问我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.bton = btn;
    [self addSubview:self.bton];
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(20 ,40 ,self.bounds.size.width-40,50)];
    //self.textfield.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.textfield];
    UIView *vive = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.textfield.frame), CGRectGetMaxY(self.textfield.frame), self.textfield.frame.size.width, 1)];
    vive.backgroundColor = [UIColor cyanColor];
    [self addSubview:vive];
    UIButton *bton = [UIButton buttonWithType:UIButtonTypeCustom];
    bton.backgroundColor = [UIColor redColor];
    bton.frame = CGRectMake(100, CGRectGetMaxY(vive.frame)+10, 150, 50);
    bton.layer.masksToBounds = YES;
    bton.layer.cornerRadius = bton.frame.size.height/4;
    [bton setTitle:@"➕添加规则" forState:UIControlStateNormal];
    [bton addTarget:self action:@selector(btonActon:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:bton];
}
-(void)buttonAction:(UIButton *)sender{
    if (sender == self.button) {
         sender.backgroundColor = [UIColor cyanColor];
        self.bton.backgroundColor = [UIColor orangeColor];
    }else if (sender == self.bton)
    {
        sender.backgroundColor = [UIColor cyanColor];
        self.button.backgroundColor = [UIColor orangeColor];
        
    }
    SWLog(@"呵呵");
   
}
-(void)btonActon:(UIButton *)sender{
    NSLog(@"规则");
}
@end
