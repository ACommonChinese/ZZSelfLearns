//
//  UIView+BMLayout.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (BMLayout)

@property (nonatomic, readonly, strong) BMLayout *layout;

- (NSArray<BMLayoutConstraint *> *)bm_makeLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block;
- (NSArray<BMLayoutConstraint *> *)bm_updateLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block;
- (NSArray<BMLayoutConstraint *> *)bm_resetLayout:(void(NS_NOESCAPE ^)(BMLayout *layout))block;

- (instancetype)bm_closestCommonSuperview:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
