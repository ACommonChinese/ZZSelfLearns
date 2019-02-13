//
//  BMLayout.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMLayoutProtocol.h"
#import "BMLayoutSupport.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMLayout : NSObject <BMLayoutProtocol>

- (instancetype)initWithView:(UIView *)view;

@property (nonatomic, readonly, strong) BMLayoutLeading *leading NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutTrailing *trailing NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutLeft *left NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutRight *right NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutTop *top NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutBottom *bottom NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutWidth *width NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutHeight *height NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutCenterX *centerX NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutCenterY *centerY NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutFirstBaseline *firstBaseline NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutLastBaseline *lastBaseline NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutSize *size NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutEdge *edge NS_AVAILABLE_IOS(9_0);
@property (nonatomic, readonly, strong) BMLayoutCenter *center NS_AVAILABLE_IOS(9_0);

@property (nonatomic, readonly, strong) BMLayoutConstraint *leadingConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *trailingConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *leftConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *rightConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *topConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *bottomConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *widthConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *heightConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *centerXConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *centerYConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *firstBaselineConstraint;
@property (nonatomic, readonly, strong) BMLayoutConstraint *lastBaselineConstraint;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *leadingConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *trailingConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *leftConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *rightConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *topConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *bottomConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *widthConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *heightConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *centerXConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *centerYConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *firstBaselineConstraints;
@property (nonatomic, readonly, strong) NSMutableArray<BMLayoutConstraint *> *lastBaselineConstraints;

@property (nonatomic, assign) BOOL updateExisting;

- (void)clear;

- (void)active;

- (void)setUp:(BMLayout *)layout;

- (void)printInfo;

- (NSArray *)getConstraints;

@end

NS_ASSUME_NONNULL_END
