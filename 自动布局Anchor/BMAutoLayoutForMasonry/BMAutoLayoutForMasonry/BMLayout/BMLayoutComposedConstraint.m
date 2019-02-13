//
//  BMLayoutComposedConstraint.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayoutComposedConstraint.h"

@implementation BMLayoutComposedConstraint

- (NSMutableArray *)children {
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

- (BMLayoutConstraint * _Nonnull (^)(UILayoutPriority))priority {
    return ^id(UILayoutPriority priority) {
        NSAssert(!self.systemConstraint.active, @"Can't set priority after active");
        for (BMLayoutConstraint *constraint in self.children) {
            constraint.systemConstraint.priority = priority;
        }
        return self;
    };
}

@end
