//
//  ACount.h
//  生产者_消费者
//
//  Created by liuweizhen on 2017/12/4.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ACount : NSObject

/// 初始化, acount: 帐户名   balance: 初始余额(以分为位)
- (instancetype)initWithAccount:(NSString *)acount balanca:(NSInteger)balance;
/// 取款
- (void)draw:(NSInteger)drawAmount;
/// 存款
- (void)deposit:(NSInteger)depositAmount;
@end
