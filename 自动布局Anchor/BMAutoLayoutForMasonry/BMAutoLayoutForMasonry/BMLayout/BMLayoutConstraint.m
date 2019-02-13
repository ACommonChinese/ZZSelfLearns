//
//  BMLayoutConstraint.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayoutConstraint.h"

@interface BMLayoutConstraint ()

@property (nonatomic, strong, readwrite) NSString *keyValue;

@end

@implementation BMLayoutConstraint

- (BMLayoutConstraint * (^)(NSString *key))key {
    return ^id(id key) {
        self.keyValue = key;
        return self;
    };
}

- (NSArray<BMLayoutConstraint *> *)children {
    return @[self];
}

- (BMLayoutConstraint * _Nonnull (^)(UILayoutPriority))priority {
    return ^id(UILayoutPriority priority) {
        if (self.systemConstraint.active) {
            return self; // Can't set priority after active
        }
        self.systemConstraint.priority = priority;
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(void))priorityRequired {
    return ^id {
        self.priority(UILayoutPriorityRequired);
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(void))priorityFittingSizeLevel {
    return ^id {
        self.priority(UILayoutPriorityFittingSizeLevel);
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(void))priorityHigh {
    return ^id {
        self.priority(UILayoutPriorityDefaultHigh);
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(void))priorityLow {
    return ^id{
        self.priority(UILayoutPriorityDefaultLow);
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(CGFloat))inset {
    return ^id(CGFloat inset) {
        [self setInset:inset];
        return self;
    };
}

- (BMLayoutConstraint * _Nonnull (^)(UIEdgeInsets))insets {
    return ^id(UIEdgeInsets insets) {
        [self setInsets:insets];
        return self;
    };
}

- (void)setInset:(CGFloat)inset {
    [self setInsets:(UIEdgeInsets){.top = inset, .left = inset, .bottom = inset, .right = inset}];
}

- (void)setInsets:(UIEdgeInsets)insets {
    for (BMLayoutConstraint *constraint in self.children) {
        switch (constraint.attribute) {
            case NSLayoutAttributeLeft:
            case NSLayoutAttributeLeading:
                constraint.systemConstraint.constant = insets.left;
                break;
            case NSLayoutAttributeTop:
                constraint.systemConstraint.constant = insets.top;
                break;
            case NSLayoutAttributeBottom:
                constraint.systemConstraint.constant = -insets.bottom;
                break;
            case NSLayoutAttributeRight:
            case NSLayoutAttributeTrailing:
                constraint.systemConstraint.constant = -insets.right;
                break;
            default:
                break;
        }
    }
}

- (BMLayoutConstraint * _Nonnull (^)(CGSize offset))sizeOffset {
    return ^id(CGSize offset) {
        [self setSizeOffset:offset];
        return self;
    };
}

- (void)setSizeOffset:(CGSize)sizeOffset {
    for (BMLayoutConstraint *constraint in self.children) {
        switch (constraint.attribute) {
            case NSLayoutAttributeWidth:
                constraint.systemConstraint.constant = sizeOffset.width;
                break;
            case NSLayoutAttributeHeight:
                constraint.systemConstraint.constant = sizeOffset.height;
                break;
            default:
                break;
        }
    }
}

- (BMLayoutConstraint * _Nonnull (^)(CGPoint))centerOffset {
    return ^id(CGPoint offset) {
        [self setCenterOffset:offset];
        return self;
    };
}

- (void)setCenterOffset:(CGPoint)centerOffset {
    for (BMLayoutConstraint *constraint in self.children) {
        switch (constraint.attribute) {
            case NSLayoutAttributeCenterX:
                constraint.systemConstraint.constant = centerOffset.x;
                break;
            case NSLayoutAttributeCenterY:
                constraint.systemConstraint.constant = centerOffset.y;
                break;
            default:
                break;
        }
    }
}

@end
