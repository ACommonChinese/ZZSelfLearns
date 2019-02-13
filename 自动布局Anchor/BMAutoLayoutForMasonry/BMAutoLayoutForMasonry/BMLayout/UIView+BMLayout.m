//
//  UIView+BMLayout.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "UIView+BMLayout.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong, readonly) BMLayout *layout;

@end


@implementation UIView (BMLayout)

- (BMLayout *)layout {
    BMLayout *layout = objc_getAssociatedObject(self, _cmd);
    if (!layout) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        layout = [[BMLayout alloc] initWithView:self];
        objc_setAssociatedObject(self, _cmd, layout, OBJC_ASSOCIATION_RETAIN);
    }
    return layout;
}

- (NSArray<BMLayoutConstraint *> *)bm_makeLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (block) {
        __weak __typeof(self) weakSelf = self;
        BMLayout *layout = [[BMLayout alloc] initWithView:weakSelf];
        block(layout);
        [layout active];
        
        // [layout printInfo];
        
        [self.layout setUp:layout];
        
        return [layout getConstraints];
    }
    return nil;
}

- (NSArray<BMLayoutConstraint *> *)bm_updateLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    if (block) {
        __weak __typeof(self) weakSelf = self;
        BMLayout *layout = [[BMLayout alloc] initWithView:weakSelf];
        layout.updateExisting = YES;
        block(layout);
        [layout active];
        
        [self.layout setUp:layout];
        
        return [layout getConstraints];
    }
    return nil;
}

- (NSArray<BMLayoutConstraint *> *)bm_resetLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self.layout clear];
    if (block) {
        __weak __typeof(self) weakSelf = self;
        BMLayout *layout = [[BMLayout alloc] initWithView:weakSelf];
        block(layout);
        [layout active];
        
        [self.layout setUp:layout];
        
        return [layout getConstraints];
    }
    return nil;
}

- (instancetype)bm_closestCommonSuperview:(UIView *)view {
    UIView *closestCommonSuperview = nil;
    
    UIView *secondViewSuperview = view;
    while (!closestCommonSuperview && secondViewSuperview) {
        UIView *firstViewSuperview = self;
        while (!closestCommonSuperview && firstViewSuperview) {
            if (secondViewSuperview == firstViewSuperview) {
                closestCommonSuperview = secondViewSuperview;
            }
            firstViewSuperview = firstViewSuperview.superview;
        }
        secondViewSuperview = secondViewSuperview.superview;
    }
    return closestCommonSuperview;
}


@end
