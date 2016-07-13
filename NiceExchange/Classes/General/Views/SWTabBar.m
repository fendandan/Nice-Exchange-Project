//
//  SWTabBar.m
//  NiceExchange
//
//  Created by Spacewalk on 16/7/13.
//  Copyright © 2016年 Spacewalk. All rights reserved.
//

#import "SWTabBar.h"

@implementation SWTabBar


- (instancetype)initWithItems:(NSArray *)items frame:(CGRect)frame {
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        
        for (int i = 0; i < items.count; i ++) {
            UIButton *button = (UIButton *)items[i];
            CGFloat width = kSelfWidth / items.count;
            button.frame = CGRectMake(i * width + 30, 0, 32, 32);
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
          
        }
           self.currebtSelectedItem = items[0];
        self.currentSelected = 0;
       
        self.allItems = items;
        self.userInteractionEnabled = NO;
    }
    return self;
}


- (void)buttonClicked:(UIButton *)button {

    self.currebtSelectedItem = button;
    for (int i = 0; i < self.allItems.count; i ++) {
        UIButton *tempButton = (UIButton *)self.allItems[i];
        if (button == tempButton) {
            self.currentSelected = i;
            tempButton.selected = YES;
        }else {
            tempButton.selected = NO;
        }
    }
    
    if (_swDelegete && [_swDelegete respondsToSelector:@selector(swTabBarItemDidClicked:)]) {
        [_swDelegete swTabBarItemDidClicked:self];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
