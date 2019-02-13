//
//  BMLayoutConstraint.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMLayoutConstraint : NSObject

@property (nonatomic, strong) NSLayoutConstraint *systemConstraint;

/// Just is key
@property (nonatomic, strong, readonly) NSString *keyValue;

/// attribute
@property (nonatomic, assign) NSLayoutAttribute attribute;

/// Sets the constraint debug name
- (BMLayoutConstraint * (^)(NSString *key))key;

- (NSArray<BMLayoutConstraint *> *)children;

- (BMLayoutConstraint * _Nonnull (^)(UILayoutPriority))priority;
- (BMLayoutConstraint * _Nonnull (^)(void))priorityRequired;
- (BMLayoutConstraint * _Nonnull (^)(void))priorityFittingSizeLevel;
- (BMLayoutConstraint * _Nonnull (^)(void))priorityHigh;
- (BMLayoutConstraint * _Nonnull (^)(void))priorityLow;
- (BMLayoutConstraint * _Nonnull (^)(CGFloat inset))inset;
- (void)setInset:(CGFloat)inset;
- (BMLayoutConstraint * _Nonnull (^)(UIEdgeInsets insets))insets;
- (void)setInsets:(UIEdgeInsets)insets;
- (BMLayoutConstraint * _Nonnull (^)(CGSize offset))sizeOffset;
- (void)setSizeOffset:(CGSize)sizeOffset;
- (BMLayoutConstraint * _Nonnull (^)(CGPoint offset))centerOffset;
- (void)setCenterOffset:(CGPoint)centerOffset;

@end

NS_ASSUME_NONNULL_END
