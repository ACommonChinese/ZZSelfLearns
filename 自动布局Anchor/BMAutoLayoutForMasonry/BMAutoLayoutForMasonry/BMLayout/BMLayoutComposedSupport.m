//
//  BMLayoutComposedSupport.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayoutComposedSupport.h"
#import "BMLayoutSupport.h"
#import "BMLayout.h"

@interface BMLayoutComposedSupport ()

@property (nonatomic, weak) id<BMLayoutProtocol> delegate;
@property (nonatomic, strong) NSMutableArray *attributes;

@end

@implementation BMLayoutComposedSupport

- (instancetype)initWithDelegate:(id<BMLayoutProtocol>)delegate composedAttributes:(NSArray *)attributes {
    self = [super init];
    if (self) {
        self.delegate = delegate;
        self.attributes = [NSMutableArray arrayWithArray:attributes];
    }
    return self;
}

- (BMLayoutComposedSupport *)leading {
    return [self addLayoutAttribute:NSLayoutAttributeLeading];
}

- (BMLayoutComposedSupport *)trailing {
    return [self addLayoutAttribute:NSLayoutAttributeTrailing];
}

- (BMLayoutComposedSupport *)left {
    return [self addLayoutAttribute:NSLayoutAttributeLeft];
}

- (BMLayoutComposedSupport *)right {
    return [self addLayoutAttribute:NSLayoutAttributeRight];
}

- (BMLayoutComposedSupport *)top {
    return [self addLayoutAttribute:NSLayoutAttributeTop];
}

- (BMLayoutComposedSupport *)bottom {
    return [self addLayoutAttribute:NSLayoutAttributeBottom];
}

- (BMLayoutComposedSupport *)width {
    return [self addLayoutAttribute:NSLayoutAttributeWidth];
}

- (BMLayoutComposedSupport *)height {
    return [self addLayoutAttribute:NSLayoutAttributeHeight];
}

- (BMLayoutComposedSupport *)centerX {
    return [self addLayoutAttribute:NSLayoutAttributeCenterX];
}

- (BMLayoutComposedSupport *)centerY {
    return [self addLayoutAttribute:NSLayoutAttributeCenterY];
}

- (BMLayoutComposedSupport *)firstBaseline {
    return [self addLayoutAttribute:NSLayoutAttributeFirstBaseline];
}

- (BMLayoutComposedSupport *)lastBaseline {
    return [self addLayoutAttribute:NSLayoutAttributeLastBaseline];
}

- (BMLayoutComposedSupport *)addLayoutAttribute:(NSLayoutAttribute)attribute {
    [self.attributes addObject:@(attribute)];
    return self;
}

- (BMLayoutComposedConstraint *)equal:(id)value {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s equal:v];
    }];
}

- (BMLayoutComposedConstraint *)greaterEqual:(id)value {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s greaterEqual:v];
    }];
}

- (BMLayoutComposedConstraint *)lessEqual:(id)value {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s lessEqual:v];
    }];
}

- (BMLayoutComposedConstraint *)equal:(id)value constant:(CGFloat)c {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s equal:v constant:c];
    }];
}

- (BMLayoutComposedConstraint *)greaterEqual:(id)value constant:(CGFloat)c {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s greaterEqual:v constant:c];
    }];
}

- (BMLayoutComposedConstraint *)lessEqual:(id)value constant:(CGFloat)c {
    return [self getComposedConstraintWith:value layoutSupport:^BMLayoutConstraint *(BMLayoutSupport *s, id v) {
        return [s lessEqual:v constant:c];
    }];
}

- (BMLayoutComposedConstraint *)getComposedConstraintWith:(id)v layoutSupport:(BMLayoutConstraint * (^)(BMLayoutSupport *s, id v))supportHandler {
    __weak __typeof(v) value = v;
    NSMutableArray<BMLayoutConstraint *> *children = [NSMutableArray array];
    if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:UIView.class] || [value isKindOfClass:NSLayoutAnchor.class]) {
        for (NSNumber *attributeNum in self.attributes) {
            NSLayoutAttribute attribute = [attributeNum unsignedIntegerValue];
            BMLayoutSupport *support = [self getLayoutSupportWithAttribute:attribute];
            if (support && supportHandler) {
                [children addObject:supportHandler(support, value)];
            }
        }
    }
    else if ([value isKindOfClass:NSArray.class]) {
        NSArray *attributeList = (NSArray *)value;
        if (self.attributes.count != attributeList.count) {
            BMLayoutThrowException(@"attribute num can't match value")
            return nil;
        }
        else {
            for (NSUInteger i = 0; i < self.attributes.count; i++) {
                NSLayoutAttribute attr = [self.attributes[i] unsignedIntegerValue];
                BMLayoutSupport *support = [self getLayoutSupportWithAttribute:attr];
                if (support && supportHandler) {
                    [children addObject:supportHandler(support, value[i])];
                }
            }
        }
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    
    BMLayoutComposedConstraint *composedConstraint = [[BMLayoutComposedConstraint alloc] init];
    composedConstraint.children = children;
    return composedConstraint;
}

- (BMLayoutSupport *)getLayoutSupportWithAttribute:(NSLayoutAttribute)attribute {
    switch (attribute) {
        case NSLayoutAttributeLeading: return self.delegate.layout.leading;
        case NSLayoutAttributeTrailing: return self.delegate.layout.trailing;
        case NSLayoutAttributeLeft: return self.delegate.layout.left;
        case NSLayoutAttributeRight: return self.delegate.layout.right;
        case NSLayoutAttributeTop: return self.delegate.layout.top;
        case NSLayoutAttributeBottom: return self.delegate.layout.bottom;
        case NSLayoutAttributeWidth: return self.delegate.layout.width;
        case NSLayoutAttributeHeight: return self.delegate.layout.height;
        case NSLayoutAttributeFirstBaseline: return self.delegate.layout.firstBaseline;
        case NSLayoutAttributeLastBaseline: return self.delegate.layout.lastBaseline;
        default: return nil;
    }
}

@end
