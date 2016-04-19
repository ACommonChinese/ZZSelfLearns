//
//  NSArray+Swizzle.m
//  Demo_1
//
//  Created by 刘威振 on 4/19/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "NSArray+Swizzle.h"

@implementation NSArray (Swizzle)

- (id)myLastObject {
    id ret = [self myLastObject]; // 乍一看，这不递归了么？别忘记这是我们准备调换IMP的selector，[self myLastObject] 将会执行真的 [self lastObject]
    NSLog(@"%s", __func__);
    return ret;
}

@end
