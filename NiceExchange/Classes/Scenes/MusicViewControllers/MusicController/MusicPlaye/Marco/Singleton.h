//
//  Singleton.h
//  DouBanProject
//
//  Created by 王佩 on 16/5/9.
//  Copyright © 2016年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#ifndef Singleton_h
#define Singleton_h
//单例声明
#define singleton_interface(className) \
+ (instancetype)shared##className

//单例实现
#define singleton_implementaton(className)\
static className * manager;\
+ (instancetype)shared##className\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        manager = [[[self class] alloc] init];\
    });\
    return manager;\
}















#endif /* Singleton_h */
