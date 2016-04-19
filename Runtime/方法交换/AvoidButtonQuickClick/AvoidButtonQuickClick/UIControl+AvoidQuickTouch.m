//
//  UIControl+AvoidQuickTouch.m
//  AvoidButtonQuickClick
//
//  Created by 刘威振 on 11/30/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import "UIControl+AvoidQuickTouch.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic) NSTimeInterval lastValidEventTime;
@end

@implementation UIControl (AvoidQuickTouch)

- (void)setMinimumEventInterval:(NSTimeInterval)minimumEventInterval {
    objc_setAssociatedObject(self, "minimumEventInterval", @(minimumEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)minimumEventInterval {
    return [objc_getAssociatedObject(self, "minimumEventInterval") doubleValue];
}

- (void)setLastValidEventTime:(NSTimeInterval)lastValidEventTime {
    objc_setAssociatedObject(self, "lastValidEventTime", @(lastValidEventTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)lastValidEventTime {
    return [objc_getAssociatedObject(self, "lastValidEventTime") doubleValue];
}

/**
 // 在app启动的时候, hook所有的按钮的 event
 // Invoked whenever a class or category is added to the Objective-C runtime; implement this method to perform class-specific behavior upon loading.
 // The load message is sent to classes and categories that are both dynamically loaded and statically linked, but only if the newly loaded class or category implements a method that can respond.
 In addition:
 A class’s +load method is called after all of its superclasses’ +load methods.
 A category +load method is called after the class’s own +load method.
 */
+ (void)load {
    Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method b = class_getInstanceMethod(self, @selector(__uxy_sendAction:to:forEvent:));
    method_exchangeImplementations(a, b); // 交换实现
}

- (void)__uxy_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    if (NSDate.date.timeIntervalSince1970 - self.lastValidEventTime < self.minimumEventInterval) return; // 如果两次事件间隔小于self.minimumEventInterval，什么都不做
    if (self.minimumEventInterval > 0) {
        self.lastValidEventTime = NSDate.date.timeIntervalSince1970;
    }
    [self __uxy_sendAction:action to:target forEvent:event];
}

@end
