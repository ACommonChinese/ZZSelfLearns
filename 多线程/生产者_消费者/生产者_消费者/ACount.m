//
//  ACount.m
//  生产者_消费者
//
//  Created by liuweizhen on 2017/12/4.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ACount.h"

@interface ACount()
/// 条件
@property (nonatomic) NSCondition *condition;
/// 帐户名
@property (nonatomic, copy) NSString *acount;
/// 余额(以分为单位)
@property (nonatomic) NSInteger balance;
@end

@implementation ACount

- (instancetype)initWithAccount:(NSString *)acount balanca:(NSInteger)balance {
    if(self = [super init]) {
        self.condition = [[NSCondition alloc] init];
        self.acount = acount;
        NSAssert(balance >= 0, @"The balance can't negative!");
        self.balance = balance;
    }
    return  self;
}

// 取钱
- (void)draw:(NSInteger)drawAmount {
    [self.condition lock]; // 加锁
    if (drawAmount > self.balance) {
        printf("\n取款%ld > 总额%ld, 取钱不成功\n----------------", drawAmount, self.balance);
        [self.condition broadcast];
        [self.condition wait]; // 线程等待
        printf("\n取款线程等待 ...\n----------------");
    } else {
        self.balance -= drawAmount;
        printf("\n取出金额: %ld 剩余金额: %ld\n----------------", drawAmount, self.balance);
    }
    [self.condition broadcast];
    [self.condition unlock]; // 解锁
}

// 存钱
- (void)deposit:(NSInteger)depositAmount {
    [self.condition lock];
    if (self.balance + depositAmount > 20000) {
        printf("\n存入金额过大\n----------------");
        [self.condition broadcast];
        [self.condition wait];
        printf("\ndeposti Just wait...\n----------------");
    } else {
        self.balance += depositAmount;
        printf("\n存入金额: %ld  剩余金额: %ld\n----------------", depositAmount, self.balance);
    }
    [self.condition broadcast];
    [self.condition unlock];
}

@end

