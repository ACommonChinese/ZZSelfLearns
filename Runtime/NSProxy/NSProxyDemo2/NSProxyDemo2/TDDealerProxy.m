//
//  TDDealerProxy.m
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "TDDealerProxy.h"
#import <objc/runtime.h>

@interface TDDealerProxy () {
    TDBookProvider          *_bookProvider;
    TDClothesProvider       *_clothesProvider;
    NSMutableDictionary     *_methodsMap;
}
@end

@implementation TDDealerProxy

#pragma mark - class method
+ (instancetype)dealerProxy{
    return [[TDDealerProxy alloc] init];
}

#pragma mark - init
- (instancetype)init{
    _methodsMap = [NSMutableDictionary dictionary];
    _bookProvider = [[TDBookProvider alloc] init];
    _clothesProvider = [[TDClothesProvider alloc] init];
    
    // 映射target及其对应方法名
    [self _registerMethodsWithTarget:_bookProvider];
    [self _registerMethodsWithTarget:_clothesProvider];
    
    return self;
}

#pragma mark - private method
- (void)_registerMethodsWithTarget:(id )target {
    unsigned int numberOfMethods = 0;
    
    // 获取target方法列表
    Method *method_list = class_copyMethodList([target class], &numberOfMethods);
    for (int i = 0; i < numberOfMethods; i++) {
        // 获取方法名并存入字典
        Method temp_method = method_list[i];
        SEL temp_sel = method_getName(temp_method);
        NSLog(@"1. %@", NSStringFromSelector(temp_sel));
        const char *temp_method_name = sel_getName(temp_sel);
        NSLog(@"2. %s", temp_method_name);
        [_methodsMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
        /**
         1. purchaseBookWithTitle:
         2. purchaseBookWithTitle:
         1. purchaseClothesWithSize:
         2. purchaseClothesWithSize:
         */
    }
}

#pragma mark - NSProxy override methods
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = invocation.selector;
    NSString *methodName = NSStringFromSelector(sel);
    // 在字典中查找对应的target
    id target = _methodsMap[methodName];
    // 检查target
    if (target && [target respondsToSelector:sel]) {
        [invocation invokeWithTarget:target];
    } else {
        [super forwardInvocation:invocation];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    // 获取选择子方法名
    NSString *methodName = NSStringFromSelector(sel);
    // 在字典中查找对应的target
    id target = _methodsMap[methodName];
    // 检查target
    if (target && [target respondsToSelector:sel]) {
        return [target methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

@end
