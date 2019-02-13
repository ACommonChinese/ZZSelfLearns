//
//  NSArray+BMAdditions.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "NSArray+BMAdditions.h"
#import "UIView+BMLayout.h"

@implementation NSArray (BMAdditions)

- (NSArray *)bm_makeLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (UIView *view in self) {
        NSAssert([view isKindOfClass:[UIView class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view bm_makeLayout:block]];
    }
    return constraints;
}

- (NSArray *)bm_updateLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (UIView *view in self) {
        NSAssert([view isKindOfClass:[UIView class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view bm_updateLayout:block]];
    }
    return constraints;
}

- (NSArray *)bm_remakeLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block {
    NSMutableArray *constraints = [NSMutableArray array];
    for (UIView *view in self) {
        NSAssert([view isKindOfClass:[UIView class]], @"All objects in the array must be views");
        [constraints addObjectsFromArray:[view bm_resetLayout:block]];
    }
    return constraints;
}

- (void)bm_distributeViewsAlongAxis:(BMAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    UIView *tempSuperView = [self bm_commonSuperviewOfViews];
    
    if (axisType == BMAxisTypeHorizontal) {
        UIView *pre;
        for (int i = 0; i < self.count; i++) {
            UIView *v = self[i];
            [v bm_makeLayout:^(BMLayout * _Nonnull layout) {
                if (pre) {
                    [layout.width equal:pre.widthAnchor];
                    [layout.left equal:pre.rightAnchor constant:fixedSpacing];
                    if (i == self.count - 1) {//last one
                        [layout.right equal:tempSuperView.rightAnchor constant:-tailSpacing];
                    }
                }
                else {//first one
                    [layout.left equal:tempSuperView.leftAnchor constant:leadSpacing];
                }
            }];
            pre = v;
        }
    }
    else {
        UIView *pre;
        for (int i = 0; i < self.count; i++) {
            UIView *v = self[i];
            [v bm_makeLayout:^(BMLayout *layout) {
                if (pre) {
                    [layout.height equal:pre.heightAnchor];
                    [layout.top equal:pre.bottomAnchor constant:fixedSpacing];
                    if (i == self.count - 1) {//last one
                        [layout.bottom equal:tempSuperView constant:-tailSpacing];
                    }
                }
                else {//first one
                    [layout.top equal:tempSuperView constant:leadSpacing];
                }
            }];
            pre = v;
        }
    }
}

- (void)bm_distributeViewsAlongAxis:(BMAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing {
    for (UIView *view in self) {
        view.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    if (self.count < 2) {
        NSAssert(self.count>1,@"views to distribute need to bigger than one");
        return;
    }
    
    UIView *tempSuperView = [self bm_commonSuperviewOfViews];
    
    for (UILayoutGuide *guide in tempSuperView.layoutGuides) {
        [tempSuperView removeLayoutGuide:guide];
    }
    
    if (axisType == BMAxisTypeHorizontal) {
        UIView *preView;
        UILayoutGuide *oneGuide;
        
        for (int i = 0; i < self.count; i++) {
            UIView *v = self[i];
            if (!preView) {//first one
                UILayoutGuide *guide = [[UILayoutGuide alloc] init];
                [tempSuperView addLayoutGuide:guide];
                
                [guide.leadingAnchor constraintEqualToAnchor:tempSuperView.leadingAnchor].active = YES;
                [guide.centerYAnchor constraintEqualToAnchor:v.centerYAnchor].active = YES;
                [guide.widthAnchor constraintEqualToConstant:leadSpacing].active = YES;
                [guide.heightAnchor constraintEqualToAnchor:v.heightAnchor].active = YES;
                
                [v bm_makeLayout:^(BMLayout * _Nonnull layout) {
                    [layout.leading equal:guide.trailingAnchor];
                    [layout.width equal:@(fixedItemLength)];
                }];
            }
            else {
                UILayoutGuide *guide = [[UILayoutGuide alloc] init];
                [tempSuperView addLayoutGuide:guide];
                [guide.leadingAnchor constraintEqualToAnchor:preView.trailingAnchor].active = YES;
                [guide.centerYAnchor constraintEqualToAnchor:v.centerYAnchor].active = YES;
                [guide.heightAnchor constraintEqualToAnchor:v.heightAnchor].active = YES;
                if (i == 1) {
                    oneGuide = guide;
                }
                else {
                    [guide.widthAnchor constraintEqualToAnchor:oneGuide.widthAnchor].active = YES;
                }
                [v bm_makeLayout:^(BMLayout * _Nonnull layout) {
                    [layout.leading equal:guide.trailingAnchor];
                    [layout.width equal:@(fixedItemLength)];
                }];
                
                if (i == self.count - 1) {//last one
                    UILayoutGuide *lastGuide = [[UILayoutGuide alloc] init];
                    [tempSuperView addLayoutGuide:lastGuide];
                    [lastGuide.leadingAnchor constraintEqualToAnchor:v.trailingAnchor].active = YES;
                    [lastGuide.centerYAnchor constraintEqualToAnchor:v.centerYAnchor].active = YES;
                    [lastGuide.heightAnchor constraintEqualToAnchor:v.heightAnchor].active = YES;
                    [lastGuide.trailingAnchor constraintEqualToAnchor:tempSuperView.trailingAnchor].active = YES;
                    [lastGuide.widthAnchor constraintEqualToConstant:tailSpacing].active = YES;
                }
            }
            
            preView = v;
        }
    }
    else {
        UIView *preView;
        UILayoutGuide *oneGuide;
        
        for (int i = 0; i < self.count; i++) {
            UIView *v = self[i];
            if (!preView) {//first one
                UILayoutGuide *guide = [[UILayoutGuide alloc] init];
                [tempSuperView addLayoutGuide:guide];
                [guide.topAnchor constraintEqualToAnchor:tempSuperView.topAnchor].active = YES;
                [guide.centerXAnchor constraintEqualToAnchor:v.centerXAnchor].active = YES;
                [guide.heightAnchor constraintEqualToConstant:leadSpacing].active = YES;
                [guide.widthAnchor constraintEqualToAnchor:v.widthAnchor].active = YES;
                
                [v.topAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
                [v.heightAnchor constraintEqualToConstant:fixedItemLength].active = YES;
            }
            else {
                UILayoutGuide *guide = [[UILayoutGuide alloc] init];
                [tempSuperView addLayoutGuide:guide];
                [guide.topAnchor constraintEqualToAnchor:preView.bottomAnchor].active = YES;
                [guide.centerXAnchor constraintEqualToAnchor:v.centerXAnchor].active = YES;
                [guide.widthAnchor constraintEqualToAnchor:v.widthAnchor].active = YES;
                if (i == 1) {
                    oneGuide = guide;
                }
                else {
                    [guide.heightAnchor constraintEqualToAnchor:oneGuide.heightAnchor].active = YES;
                }
                [v.topAnchor constraintEqualToAnchor:guide.bottomAnchor].active = YES;
                [v.heightAnchor constraintEqualToConstant:fixedItemLength].active = YES;
                
                if (i == self.count - 1) {//last one
                    UILayoutGuide *lastGuide = [[UILayoutGuide alloc] init];
                    [tempSuperView addLayoutGuide:lastGuide];
                    [lastGuide.topAnchor constraintEqualToAnchor:v.bottomAnchor].active = YES;
                    [lastGuide.centerXAnchor constraintEqualToAnchor:v.centerXAnchor].active = YES;
                    [lastGuide.widthAnchor constraintEqualToAnchor:v.widthAnchor].active = YES;
                    [lastGuide.bottomAnchor constraintEqualToAnchor:tempSuperView.bottomAnchor].active = YES;
                    [lastGuide.heightAnchor constraintEqualToConstant:tailSpacing].active = YES;
                }
            }
            
            preView = v;
        }
    }
}

- (UIView *)bm_commonSuperviewOfViews {
    UIView *commonSuperview = nil;
    UIView *previousView = nil;
    for (id object in self) {
        if ([object isKindOfClass:[UIView class]]) {
            UIView *view = (UIView *)object;
            if (previousView) {
                commonSuperview = [view bm_closestCommonSuperview:commonSuperview];
            }
            else {
                commonSuperview = view;
            }
            previousView = view;
        }
    }
    NSAssert(commonSuperview, @"Can't constrain views that do not share a common superview. Make sure that all the views in this array have been added into the same view hierarchy.");
    return commonSuperview;
}

@end
