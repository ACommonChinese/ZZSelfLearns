//
//  BMLayoutComposedSupport.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLayoutComposedConstraint.h"
#import "BMLayoutProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMLayoutComposedSupport : NSObject

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

- (instancetype)initWithDelegate:(id<BMLayoutProtocol>)delegate composedAttributes:(NSArray *)attributes;

- (BMLayoutComposedConstraint *)equal:(id)value;
- (BMLayoutComposedConstraint *)greaterEqual:(id)value;
- (BMLayoutComposedConstraint *)lessEqual:(id)value;
- (BMLayoutComposedConstraint *)equal:(id)value constant:(CGFloat)c;
- (BMLayoutComposedConstraint *)greaterEqual:(id)value constant:(CGFloat)c;
- (BMLayoutComposedConstraint *)lessEqual:(id)value constant:(CGFloat)c;

@end

NS_ASSUME_NONNULL_END
