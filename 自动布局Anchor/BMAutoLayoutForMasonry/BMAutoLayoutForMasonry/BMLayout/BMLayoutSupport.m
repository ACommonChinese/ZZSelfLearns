//
//  BMLayoutSupport.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayoutSupport.h"
#import "UIView+BMLayout.h"
#import "BMLayoutComposedConstraint.h"
#import "BMLayout.h"

// ---------------------------------------------------------------
//                       BMLayoutSupport
// ---------------------------------------------------------------
@interface BMLayoutSupport ()

- (NSLayoutAttribute)attribute;
- (NSLayoutAnchor *)anchor;
- (NSLayoutAnchor *)superAnchor;
- (NSMutableArray<BMLayoutConstraint *> *)constraints;
- (NSArray<BMLayoutConstraint *> *)viewConstraints;

@end

@implementation BMLayoutSupport

- (BMLayoutConstraint *)addConstraint:(NSLayoutConstraint *)c {
    if (!c) return nil;
    
    BMLayoutConstraint *existConstraint = nil;
    if (self.delegate.layout.updateExisting) {
        existConstraint = [self getSimiliarConstraint:c];
    }
    if (existConstraint) {
        // just update the constant
        existConstraint.systemConstraint.constant = c.constant;
        return existConstraint;
    }
    else {
        BMLayoutConstraint *constraint = [[BMLayoutConstraint alloc] init];
        constraint.attribute = self.attribute;
        constraint.systemConstraint = c;
        [self.constraints addObject:constraint];
//
//        NSLog(@"1. ************ %@ -- %@", self.delegate.layout.attachView, self.delegate.layout.topConstraints);
//        NSLog(@"2. ************ %@ -- %@", self.delegate.layout.attachView, self.delegate.layout.heightConstraints);
        return constraint;
    }
}

- (BMLayoutConstraint *)getSimiliarConstraint:(NSLayoutConstraint *)current {
    for (BMLayoutConstraint *constraint in self.viewConstraints) {
        NSLayoutConstraint *existingConstraint = constraint.systemConstraint;
        if (existingConstraint.firstAnchor != current.firstAnchor) continue;
        if (existingConstraint.secondAnchor != current.secondAnchor) continue;
        if (existingConstraint.relation != current.relation) continue;
        if (existingConstraint.multiplier != current.multiplier) continue;
        
        return constraint;
    }
    return nil;
}

- (NSLayoutAttribute)attribute {
    BMLayoutThrowException(@"attribute should be implement by subclass")
}

- (NSLayoutAnchor *)anchor {
    BMLayoutThrowException(@"anchor should be implement by subclass")
}

- (NSLayoutAnchor *)superAnchor {
    BMLayoutThrowException(@"superAnchor should be implement by subclass")
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    BMLayoutThrowException(@"constraints should be implement by subclass")
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    BMLayoutThrowException(@"viewConstraints should be implement by subclass")
}

- (BMLayoutConstraint *)equal:(id)value {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintEqualToAnchor:value];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintEqualToAnchor:self.superAnchor constant:[value floatValue]];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value]];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value]];
    }
    
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)greaterEqual:(id)value {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:value];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:self.superAnchor constant:[value floatValue]];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value]];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value]];
    }
    
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)lessEqual:(id)value {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:value];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:self.superAnchor constant:[value floatValue]];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value]];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value]];
    }
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintEqualToAnchor:value constant:c];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintEqualToAnchor:self.superAnchor constant:[value floatValue]+c];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value] constant:c];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value] constant:c];
    }
    
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)greaterEqual:(id)value constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:value constant:c];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:self.superAnchor constant:[value floatValue]+c];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value] constant:c];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintGreaterThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value] constant:c];
    }
    
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)lessEqual:(id)value constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:[NSLayoutAnchor class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:value constant:c];
    }
    else if ([value isKindOfClass:[NSNumber class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:self.superAnchor constant:[value floatValue]+c];
    }
    else if ([value isKindOfClass:[UIView class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:(UIView *)value] constant:c];
    }
    else if ([value isKindOfClass:[UILayoutGuide class]]) {
        constraint = [self.anchor constraintLessThanOrEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:(UILayoutGuide *)value] constant:c];
    }
    
    return [self addConstraint:constraint];
}

- (BMLayoutComposedSupport *)getComposedSupportWithAttribute:(NSLayoutAttribute)attribute {
    return [[BMLayoutComposedSupport alloc] initWithDelegate:self.delegate composedAttributes:@[@(self.attribute), @(attribute)]];
}

- (BMLayoutComposedSupport *)leading {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeLeading];
}

- (BMLayoutComposedSupport *)trailing {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeTrailing];
}

- (BMLayoutComposedSupport *)left {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeLeft];
}

- (BMLayoutComposedSupport *)right {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeRight];
}

- (BMLayoutComposedSupport *)top {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeTop];
}

- (BMLayoutComposedSupport *)bottom {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeBottom];
}

- (BMLayoutComposedSupport *)width {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeWidth];
}

- (BMLayoutComposedSupport *)height {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeHeight];
}

- (BMLayoutComposedSupport *)centerX {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeCenterX];
}

- (BMLayoutComposedSupport *)centerY {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeCenterY];
}

- (BMLayoutComposedSupport *)firstBaseline {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeFirstBaseline];
}

- (BMLayoutComposedSupport *)lastBaseline {
    return [self getComposedSupportWithAttribute:NSLayoutAttributeLastBaseline];
}

@end

// ---------------------------------------------------------------
//                       BMLayoutLeading
// ---------------------------------------------------------------
@implementation BMLayoutLeading : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeLeading;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.leadingAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.leadingAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.leadingConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.leadingConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutTrailing
// ---------------------------------------------------------------
@implementation BMLayoutTrailing : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeTrailing;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.trailingAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.trailingAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.trailingConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.trailingConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutLeft
// ---------------------------------------------------------------
@implementation BMLayoutLeft : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeLeft;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.leftAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.leftAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.leftConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.leftConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutRight
// ---------------------------------------------------------------
@implementation BMLayoutRight : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeRight;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.rightAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.rightAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.rightConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.rightConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutTop
// ---------------------------------------------------------------
@implementation BMLayoutTop : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeTop;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.topAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.topAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.topConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.topConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutBottom
// ---------------------------------------------------------------
@implementation BMLayoutBottom : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeBottom;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.bottomAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.bottomAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.bottomConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.bottomConstraints;
}

@end

// ---------------------------------------------------------------
//                   BMLayoutDimensionSupport
// ---------------------------------------------------------------
@implementation BMLayoutDimensionSupport : BMLayoutSupport

- (BMLayoutConstraint *)equal:(id)value {
    if ([value isKindOfClass:NSLayoutAnchor.class]) {
        NSLayoutConstraint *constraint = [self.anchor constraintEqualToAnchor:value];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        NSLayoutConstraint *constraint = [(NSLayoutDimension *)self.anchor constraintEqualToConstant:[value floatValue]];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:UIView.class]) {
        NSLayoutConstraint *constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:value]];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:NSArray.class]) {
        BMLayoutComposedConstraint *constraint = BMLayoutComposedConstraint.new;
        for (id v in value) {
            [constraint.children addObject:[super equal:v]];
        }
        return constraint;
    }
    else if ([value isKindOfClass:UILayoutGuide.class]) {
        NSLayoutConstraint *constraint = [(NSLayoutDimension *)self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:value]];
        return [self addConstraint:constraint];
    }
    BMLayoutThrowTypeInvalidException
}

- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c {
    if ([value isKindOfClass:NSLayoutAnchor.class]) {
        NSLayoutConstraint *constraint = [self.anchor constraintEqualToAnchor:value constant:c];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        NSLayoutConstraint *constraint = [(NSLayoutDimension *)self.anchor constraintEqualToConstant:[value floatValue]+c];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:UIView.class]) {
        NSLayoutConstraint *constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofView:value] constant:c];
        return [self addConstraint:constraint];
    }
    else if ([value isKindOfClass:NSArray.class]) {
        BMLayoutComposedConstraint *constraint = BMLayoutComposedConstraint.new;
        for (id v in value) {
            [constraint.children addObject:[super equal:v]];
        }
        return constraint;
    }
    else if ([value isKindOfClass:UILayoutGuide.class]) {
        NSLayoutConstraint *constraint = [self.anchor constraintEqualToAnchor:[self.delegate getAnchor:self.attribute ofGuide:value] constant:c];
        return [self addConstraint:constraint];
    }
    BMLayoutThrowTypeInvalidException
}

- (BMLayoutConstraint *)equal:(id)value multiplier:(CGFloat)m {
    return [self equal:value multiplier:m constant:0];
}

- (BMLayoutConstraint *)lessEqual:(id)value multiplier:(CGFloat)m {
    return [self lessEqual:value multiplier:m constant:0];
}

- (BMLayoutConstraint *)greaterEqual:(id)value multiplier:(CGFloat)m {
    return [self greaterEqual:value multiplier:m constant:0];
}

- (BMLayoutConstraint *)equal:(id)value multiplier:(CGFloat)m constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:NSLayoutAnchor.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintEqualToAnchor:value multiplier:m constant:c];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintEqualToConstant:[value floatValue]*m+c];
    }
    else if ([value isKindOfClass:UIView.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofView:value] multiplier:m constant:c];
    }
    else if ([value isKindOfClass:UILayoutGuide.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofGuide:value] multiplier:m constant:c];
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)lessEqual:(id)value multiplier:(CGFloat)m constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:NSLayoutAnchor.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintLessThanOrEqualToAnchor:value multiplier:m constant:c];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintLessThanOrEqualToConstant:[value floatValue]*m+c];
    }
    else if ([value isKindOfClass:UIView.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintLessThanOrEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofView:value] multiplier:m constant:c];
    }
    else if ([value isKindOfClass:UILayoutGuide.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintLessThanOrEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofGuide:value] multiplier:m constant:c];
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    return [self addConstraint:constraint];
}

- (BMLayoutConstraint *)greaterEqual:(id)value multiplier:(CGFloat)m constant:(CGFloat)c {
    NSLayoutConstraint *constraint = nil;
    if ([value isKindOfClass:NSLayoutAnchor.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintGreaterThanOrEqualToAnchor:value multiplier:m constant:c];
    }
    else if ([value isKindOfClass:NSNumber.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintGreaterThanOrEqualToConstant:[value floatValue]*m+c];
    }
    else if ([value isKindOfClass:UIView.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintGreaterThanOrEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofView:value] multiplier:m constant:c];
    }
    else if ([value isKindOfClass:UILayoutGuide.class]) {
        constraint = [(NSLayoutDimension *)self.anchor constraintGreaterThanOrEqualToAnchor:(NSLayoutDimension *)[self.delegate getAnchor:self.attribute ofGuide:value] multiplier:m constant:c];
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    return [self addConstraint:constraint];
}

@end

// ---------------------------------------------------------------
//                       BMLayoutWidth
// ---------------------------------------------------------------
@implementation BMLayoutWidth : BMLayoutDimensionSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeWidth;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.widthAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.widthAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.widthConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.widthConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutHeight
// ---------------------------------------------------------------
@implementation BMLayoutHeight : BMLayoutDimensionSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeHeight;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.heightAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.heightAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.heightConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.heightConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutCenterX
// ---------------------------------------------------------------
@implementation BMLayoutCenterX : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeCenterX;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.centerXAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.centerXAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.centerXConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.centerXConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutCenterY
// ---------------------------------------------------------------
@implementation BMLayoutCenterY : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeCenterY;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.centerYAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.centerYAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.centerYConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.centerYConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutFirstBaseline
// ---------------------------------------------------------------
@implementation BMLayoutFirstBaseline : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeFirstBaseline;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.firstBaselineAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.firstBaselineAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.firstBaselineConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.firstBaselineConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutLastBaseline
// ---------------------------------------------------------------
@implementation BMLayoutLastBaseline : BMLayoutSupport

- (NSLayoutAttribute)attribute {
    return NSLayoutAttributeLastBaseline;
}

- (NSLayoutAnchor *)anchor {
    return self.delegate.attachView.lastBaselineAnchor;
}

- (NSLayoutAnchor *)superAnchor {
    return self.delegate.attachView.superview.lastBaselineAnchor;
}

- (NSMutableArray<BMLayoutConstraint *> *)constraints {
    return self.delegate.layout.lastBaselineConstraints;
}

- (NSArray<BMLayoutConstraint *> *)viewConstraints {
    return self.delegate.layout.attachView.layout.lastBaselineConstraints;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutSize
// ---------------------------------------------------------------
@implementation BMLayoutSize

- (BMLayoutConstraint *)equal:(id)value {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id width, id height) {
        return @[[self.delegate.layout.width equal:width], [self.delegate.layout.height equal:height]];
    }];
}

- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id width, id height) {
        return @[[self.delegate.layout.width equal:width constant:c], [self.delegate.layout.height equal:height constant:c]];
    }];
}

- (BMLayoutConstraint *)getConstraintWithValue:(id)value handler:(NSArray<BMLayoutConstraint *> * (^)(id width, id height))handler {
    BMLayoutComposedConstraint *composedConstraint = BMLayoutComposedConstraint.new;
    id width = nil;
    id height = nil;
    if ([value isKindOfClass:NSArray.class]) {
        width = value[0];
        height = value[1];
    }
    else if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:UIView.class]) {
        width = height = value;
    }
    else if ([value isKindOfClass:NSValue.class] && strcmp(((NSValue *)value).objCType, @encode(CGSize)) == 0) {
        CGSize size;
        [value getValue:&size];
        width = @(size.width);
        height = @(size.height);
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    NSArray *constraints = handler(width, height);
    for (BMLayoutConstraint *constraint in constraints) {
        [composedConstraint.children addObjectsFromArray:constraint.children];
    }
    return composedConstraint;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutEdge
// ---------------------------------------------------------------
@implementation BMLayoutEdge

- (BMLayoutConstraint *)equal:(id)value {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id top, id left, id bottom, id right) {
        return @[[self.delegate.layout.top equal:top],
                 [self.delegate.layout.left equal:left],
                 [self.delegate.layout.bottom equal:bottom],
                 [self.delegate.layout.right equal:right]];
    }];
}

- (BMLayoutConstraint *)equal:(id)value inset:(UIEdgeInsets)insets {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id top, id left, id bottom, id right) {
        return @[[self.delegate.layout.top equal:top constant:insets.top],
                 [self.delegate.layout.left equal:left constant:insets.left],
                 [self.delegate.layout.bottom equal:bottom constant:-insets.bottom],
                 [self.delegate.layout.right equal:right constant:-insets.right]];
    }];
}

- (BMLayoutConstraint *)getConstraintWithValue:(id)value handler:(NSArray<BMLayoutConstraint *> * (^)(id top, id left, id bottom, id right))handler {
    BMLayoutComposedConstraint *composedConstraint = BMLayoutComposedConstraint.new;
    id top    = nil;
    id left   = nil;
    id bottom = nil;
    id right  = nil;
    if ([value isKindOfClass:NSArray.class]) {
        top    = value[0];
        left   = value[1];
        bottom = value[2];
        right  = value[3];
    }
    else if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:UIView.class] || [value isKindOfClass:UILayoutGuide.class]) {
        top = left = bottom = right = value;
    }
    else if ([value isKindOfClass:NSValue.class] && strcmp(((NSValue *)value).objCType, @encode(UIEdgeInsets)) == 0) {
        UIEdgeInsets insets;
        [value getValue:&insets];
        top    = @(insets.top);
        left   = @(insets.left);
        bottom = @(-insets.bottom);
        right  = @(-insets.right);
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    NSArray *constraints = handler(top, left, bottom, right);
    for (BMLayoutConstraint *constraint in constraints) {
        [composedConstraint.children addObjectsFromArray:constraint.children];
    }
    return composedConstraint;
}

@end

// ---------------------------------------------------------------
//                       BMLayoutCenter
// ---------------------------------------------------------------
@implementation BMLayoutCenter

- (BMLayoutConstraint *)equal:(id)value {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX equal:centerX],
                 [self.delegate.layout.centerY equal:centerY]];
    }];
}

- (BMLayoutConstraint *)greaterEqual:(id)value {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX greaterEqual:centerX],
                 [self.delegate.layout.centerY greaterEqual:centerY]];
    }];
}

- (BMLayoutConstraint *)lessEqual:(id)value {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX lessEqual:centerX],
                 [self.delegate.layout.centerY lessEqual:centerY]];
    }];
}

- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX equal:centerX constant:c],
                 [self.delegate.layout.centerY equal:centerY constant:c]];
    }];
}

- (BMLayoutConstraint *)greaterEqual:(id)value constant:(CGFloat)c {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX greaterEqual:centerX constant:c],
                 [self.delegate.layout.centerY greaterEqual:centerY constant:c]];
    }];
}

- (BMLayoutConstraint *)lessEqual:(id)value constant:(CGFloat)c {
    return [self getConstraintWithValue:value handler:^NSArray<BMLayoutConstraint *> *(id centerX, id centerY) {
        return @[[self.delegate.layout.centerX lessEqual:value constant:c],
                 [self.delegate.layout.centerY lessEqual:value constant:c]];
    }];
}

- (BMLayoutConstraint *)getConstraintWithValue:(id)value handler:(NSArray<BMLayoutConstraint *> * (^)(id centerX, id centerY))handler {
    BMLayoutComposedConstraint *composedConstraint = BMLayoutComposedConstraint.new;
    id centerX = nil;
    id centerY = nil;
    if ([value isKindOfClass:NSArray.class]) {
        centerX = value[0];
        centerY = value[1];
    }
    else if ([value isKindOfClass:NSNumber.class] || [value isKindOfClass:UIView.class] || [value isKindOfClass:UILayoutGuide.class]) {
        centerX = centerY = value;
    }
    else if ([value isKindOfClass:NSValue.class] && strcmp(((NSValue *)value).objCType, @encode(CGPoint)) == 0) {
        CGPoint point;
        [value getValue:&point];
        centerX = @(point.x);
        centerY = @(point.y);
    }
    else {
        BMLayoutThrowTypeInvalidException
    }
    NSArray *constraints = handler(centerX, centerY);
    for (BMLayoutConstraint *constraint in constraints) {
        [composedConstraint.children addObjectsFromArray:constraint.children];
    }
    return composedConstraint;
}

@end
