//
//  main.m
//  Demo_1
//
//  Created by 刘威振 on 4/19/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import "NSArray+Swizzle.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Method originMethod = class_getInstanceMethod([NSArray class], @selector(lastObject));
        Method myMethod = class_getInstanceMethod([NSArray class], @selector(myLastObject));
        method_exchangeImplementations(originMethod, myMethod);
        NSArray *array = @[@"0", @"1", @"2", @"3"];
        NSString *string = [array lastObject];
        NSLog(@"%@", string);
        /**
         * 程序执行结果：
         -[NSArray(Swizzle) myLastObject]
         3
         */
    }
    return 0;
}
