//
//  ZZMessage.m
//  methodForward
//
//  Created by liuweizhen on 2017/11/11.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZMessage.h"
#import <objc/runtime.h>
#import "ZZMessageForwarding.h"

@implementation ZZMessage

/** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ZZMessage sendMessage:]: unrecognized selector sent to instance 0x1028071d0'
- (void)sendMessage:(NSString *)word {
    NSLog(@"normal way : send message = %@", word);
}
 */

// + (BOOL)resolveClassMethod:(SEL)sel
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(sendMessage:)) {
//        class_addMethod([self class], sel, imp_implementationWithBlock(^(id self, NSString *word) {
//            NSLog(@"method resolution way : send message = %@", word);
//        }), "v@*"); // https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100-SW1
//    }
//    return YES;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(sendMessage:)) {
//        return [[ZZMessageForwarding alloc] init];
//    }
//    return nil;
//}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *methodSignature = [super methodSignatureForSelector:aSelector];
    if (!methodSignature) {
        methodSignature = [NSMethodSignature signatureWithObjCTypes:"v@:*"];
    }
    return methodSignature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    ZZMessageForwarding *messageForwarding = [ZZMessageForwarding new];
    if ([messageForwarding respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:messageForwarding];
    }
}

@end
