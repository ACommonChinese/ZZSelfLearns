//
//  BMLayoutSupport.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLayoutConstraint.h"
#import "BMLayoutProtocol.h"
#import "BMLayoutUtilities.h"
#import "BMLayoutComposedSupport.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMLayoutSupport : NSObject

@property (nonatomic, weak) id<BMLayoutProtocol> delegate;

- (BMLayoutConstraint *)equal:(id)value;
- (BMLayoutConstraint *)greaterEqual:(id)value;
- (BMLayoutConstraint *)lessEqual:(id)value;
- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c;
- (BMLayoutConstraint *)greaterEqual:(id)value constant:(CGFloat)c;
- (BMLayoutConstraint *)lessEqual:(id)value constant:(CGFloat)c;

@property (nonatomic, readonly, strong) BMLayoutComposedSupport *leading;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *trailing;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *left;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *right;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *top;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *bottom;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *width;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *height;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *centerX;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *centerY;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *firstBaseline;
@property (nonatomic, readonly, strong) BMLayoutComposedSupport *lastBaseline;

@end

@interface BMLayoutLeading : BMLayoutSupport

@end

@interface BMLayoutTrailing : BMLayoutSupport

@end

@interface BMLayoutLeft : BMLayoutSupport

@end

@interface BMLayoutRight : BMLayoutSupport

@end

@interface BMLayoutTop : BMLayoutSupport

@end

@interface BMLayoutBottom : BMLayoutSupport

@end

@interface BMLayoutDimensionSupport : BMLayoutSupport

- (BMLayoutConstraint *)equal:(id)value multiplier:(CGFloat)m;
- (BMLayoutConstraint *)lessEqual:(id)value multiplier:(CGFloat)m;
- (BMLayoutConstraint *)greaterEqual:(id)value multiplier:(CGFloat)m;
- (BMLayoutConstraint *)equal:(id)value multiplier:(CGFloat)m constant:(CGFloat)c;
- (BMLayoutConstraint *)lessEqual:(id)value multiplier:(CGFloat)m constant:(CGFloat)c;
- (BMLayoutConstraint *)greaterEqual:(id)value multiplier:(CGFloat)m constant:(CGFloat)c;

@end

@interface BMLayoutWidth : BMLayoutDimensionSupport

@end

@interface BMLayoutHeight : BMLayoutDimensionSupport

@end

@interface BMLayoutCenterX : BMLayoutSupport

@end

@interface BMLayoutCenterY : BMLayoutSupport

@end

@interface BMLayoutFirstBaseline : BMLayoutSupport

@end

@interface BMLayoutLastBaseline : BMLayoutSupport

@end

@interface BMLayoutSize : NSObject

@property (nonatomic, weak) id<BMLayoutProtocol> delegate;

- (BMLayoutConstraint *)equal:(id)value;
- (BMLayoutConstraint *)equal:(id)value constant:(CGFloat)c;

@end

@interface BMLayoutEdge : NSObject

@property (nonatomic, weak) id<BMLayoutProtocol> delegate;

- (BMLayoutConstraint *)equal:(id)value;
- (BMLayoutConstraint *)equal:(id)value inset:(UIEdgeInsets)insets;

@end

@interface BMLayoutCenter : BMLayoutSupport

@end

NS_ASSUME_NONNULL_END
