//
//  HttpProxy.m
//  NSProxyDemo_4_HttpProxy
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "HttpProxy.h"
#import <objc/runtime.h>

@interface HttpProxy ()
@property(strong, nonatomic) NSMutableDictionary *selToHandlerMap;
@end

@implementation HttpProxy

#pragma mark - Public methods

+ (instancetype)sharedInstance {
    static HttpProxy *httpProxy = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpProxy = [HttpProxy alloc];
        httpProxy.selToHandlerMap = [NSMutableDictionary new];
    });
    
    return httpProxy;
}

- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler {
    unsigned int numberOfMethods = 0;
    struct objc_method_description *methods = protocol_copyMethodDescriptionList(httpProtocol, YES, YES, &numberOfMethods);
    for (unsigned int i = 0; i < numberOfMethods; i++) {
        struct objc_method_description method = methods[i];
        [_selToHandlerMap setValue:handler forKey:NSStringFromSelector(method.name)];
    }
}

#pragma mark - Methods route
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSString *methodName = NSStringFromSelector(sel);
    id handler = [_selToHandlerMap valueForKey:methodName];
    if (handler != nil && [handler respondsToSelector:sel]) {
        return [handler methodSignatureForSelector:sel];
    } else {
        return [super methodSignatureForSelector:sel];
    }
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    NSString *methodsName = NSStringFromSelector(invocation.selector);
    id handler = [_selToHandlerMap valueForKey:methodsName];
    if (handler != nil && [handler respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:handler];
    } else {
        [super forwardInvocation:invocation];
    }
}

@end
