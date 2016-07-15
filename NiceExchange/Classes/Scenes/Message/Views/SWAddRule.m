//
//  SWAddRule.m
//  NiceExchange
//
//  Created by lanou3g on 16/7/15.
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
    UIButton *butt = [UIButton buttonWithType:UIButtonTypeCustom];
    butt.frame =  CGRectMake(40,10,100, 30);
    butt.backgroundColor = [UIColor orangeColor];
    [butt setTitle:@"大家聊聊" forState:UIControlStateNormal];
    [butt addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self addSubview:butt];
    btn.frame = CGRectMake(160, 10, 100, 30);
    btn.backgroundColor = [UIColor orangeColor];
    [btn setTitle:@"尽管问我" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:btn];
    self.textfield = [[UITextField alloc]initWithFrame:CGRectMake(0 ,50 , 300, 100)];
    self.textfield.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.textfield];
    UIButton *bton = [UIButton buttonWithType:UIButtonTypeCustom];
    bton.backgroundColor = [UIColor redColor];
    bton.frame = CGRectMake(80, 170, 150, 50);
    [bton setTitle:@"➕添加规则" forState:UIControlStateNormal];
    [bton addTarget:self action:@selector(btonActon:) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:bton];
}
-(void)buttonAction:(UIButton *)sender{
    NSLog(@"一起聊聊");
}
-(void)btnAction:(UIButton *)sender{
    NSLog(@"尽管问我");
}
-(void)btonActon:(UIButton *)sender{
    NSLog(@"规则");
}

@end
