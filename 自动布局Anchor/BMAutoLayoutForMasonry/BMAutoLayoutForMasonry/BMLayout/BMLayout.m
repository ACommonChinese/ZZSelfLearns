//
//  BMLayout.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/1.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMLayout.h"

#define BMLayout_lazy_load(ClassName, varName, code) \
- (ClassName *)varName { \
    if (_##varName == nil) { \
        _##varName = ClassName.new; \
        code \
    } \
    return _##varName; \
}

@interface BMLayout ()

@property (nonatomic, weak) UIView *view;

@property (nonatomic, readwrite, strong) BMLayoutLeading *leading;
@property (nonatomic, readwrite, strong) BMLayoutTrailing *trailing;
@property (nonatomic, readwrite, strong) BMLayoutLeft *left;
@property (nonatomic, readwrite, strong) BMLayoutRight *right;
@property (nonatomic, readwrite, strong) BMLayoutTop *top;
@property (nonatomic, readwrite, strong) BMLayoutBottom *bottom;
@property (nonatomic, readwrite, strong) BMLayoutWidth *width;
@property (nonatomic, readwrite, strong) BMLayoutHeight *height;
@property (nonatomic, readwrite, strong) BMLayoutCenterX *centerX;
@property (nonatomic, readwrite, strong) BMLayoutCenterY *centerY;
@property (nonatomic, readwrite, strong) BMLayoutFirstBaseline *firstBaseline;
@property (nonatomic, readwrite, strong) BMLayoutLastBaseline *lastBaseline;
@property (nonatomic, readwrite, strong) BMLayoutSize *size;
@property (nonatomic, readwrite, strong) BMLayoutEdge *edge;
@property (nonatomic, readwrite, strong) BMLayoutCenter *center;

@property (nonatomic, readwrite, strong) BMLayoutConstraint *leadingConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *trailingConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *leftConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *rightConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *topConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *bottomConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *widthConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *heightConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *centerXConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *centerYConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *firstBaselineConstraint;
@property (nonatomic, readwrite, strong) BMLayoutConstraint *lastBaselineConstraint;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *leadingConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *trailingConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *leftConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *rightConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *topConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *bottomConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *widthConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *heightConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *centerXConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *centerYConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *firstBaselineConstraints;
@property (nonatomic, readwrite, strong) NSMutableArray<BMLayoutConstraint *> *lastBaselineConstraints;

@end

@implementation BMLayout

- (instancetype)initWithView:(UIView *)view {
    self = [super init];
    if (!self) return nil;
    self.view = view;
    return self;
}

BMLayout_lazy_load(BMLayoutLeading, leading, { _leading.delegate = self; })
BMLayout_lazy_load(BMLayoutTrailing, trailing, {_trailing.delegate = self;})
BMLayout_lazy_load(BMLayoutLeft, left, {_left.delegate = self;})
BMLayout_lazy_load(BMLayoutRight, right, {_right.delegate = self;})
BMLayout_lazy_load(BMLayoutTop, top, {_top.delegate = self;})
BMLayout_lazy_load(BMLayoutBottom, bottom, {_bottom.delegate = self;})
BMLayout_lazy_load(BMLayoutWidth, width, {_width.delegate = self;})
BMLayout_lazy_load(BMLayoutHeight, height, {_height.delegate = self;})
BMLayout_lazy_load(BMLayoutCenterX, centerX, {_centerX.delegate = self;})
BMLayout_lazy_load(BMLayoutCenterY, centerY, {_centerY.delegate = self;})
BMLayout_lazy_load(BMLayoutFirstBaseline, firstBaseline, {_firstBaseline.delegate = self;})
BMLayout_lazy_load(BMLayoutLastBaseline, lastBaseline, {_lastBaseline.delegate = self;})
BMLayout_lazy_load(BMLayoutSize, size, { _size.delegate = self; })
BMLayout_lazy_load(BMLayoutEdge, edge, { _edge.delegate = self; })
BMLayout_lazy_load(BMLayoutCenter, center, { _center.delegate = self; })

BMLayout_lazy_load(NSMutableArray, leadingConstraints, ;)
BMLayout_lazy_load(NSMutableArray, trailingConstraints, ;)
BMLayout_lazy_load(NSMutableArray, leftConstraints, ;)
BMLayout_lazy_load(NSMutableArray, rightConstraints, ;)
BMLayout_lazy_load(NSMutableArray, topConstraints, ;)
BMLayout_lazy_load(NSMutableArray, bottomConstraints, ;)
BMLayout_lazy_load(NSMutableArray, widthConstraints, ;)
BMLayout_lazy_load(NSMutableArray, heightConstraints, ;)
BMLayout_lazy_load(NSMutableArray, centerXConstraints, ;)
BMLayout_lazy_load(NSMutableArray, centerYConstraints, ;)
BMLayout_lazy_load(NSMutableArray, firstBaselineConstraints, ;)
BMLayout_lazy_load(NSMutableArray, lastBaselineConstraints, ;)

- (BMLayoutConstraint *)leadingConstraint {
    return self.leadingConstraints.firstObject;
}

- (BMLayoutConstraint *)trailingConstraint {
    return self.trailingConstraints.firstObject;
}

- (BMLayoutConstraint *)leftConstraint {
    return self.leftConstraints.firstObject;
}

- (BMLayoutConstraint *)rightConstraint {
    return self.rightConstraints.firstObject;
}

- (BMLayoutConstraint *)topConstraint {
    return self.topConstraints.firstObject;
}

- (BMLayoutConstraint *)bottomConstraint {
    return self.bottomConstraints.firstObject;
}

- (BMLayoutConstraint *)widthConstraint {
    return self.widthConstraints.firstObject;
}

- (BMLayoutConstraint *)heightConstraint {
    return self.heightConstraints.firstObject;
}

- (BMLayoutConstraint *)centerXConstraint {
    return self.centerXConstraints.firstObject;
}

- (BMLayoutConstraint *)centerYConstraint {
    return self.centerYConstraints.firstObject;
}

- (BMLayoutConstraint *)firstBaselineConstraint {
    return self.firstBaselineConstraints.firstObject;
}

- (BMLayoutConstraint *)lastBaselineConstraint {
    return self.lastBaselineConstraints.firstObject;
}

- (void)clear {
    [self clearConstraints:self.leadingConstraints];
    [self clearConstraints:self.trailingConstraints];
    [self clearConstraints:self.leftConstraints];
    [self clearConstraints:self.rightConstraints];
    [self clearConstraints:self.topConstraints];
    [self clearConstraints:self.bottomConstraints];
    [self clearConstraints:self.widthConstraints];
    [self clearConstraints:self.heightConstraints];
    [self clearConstraints:self.centerXConstraints];
    [self clearConstraints:self.centerYConstraints];
    [self clearConstraints:self.firstBaselineConstraints];
    [self clearConstraints:self.lastBaselineConstraints];
}

- (void)clearConstraints:(NSMutableArray *)array {
    for (BMLayoutConstraint *c in array) {
        c.systemConstraint.active = NO;
    }
    [array removeAllObjects];
}

- (void)clearGuides:(NSMutableArray *)guides {
    for (UILayoutGuide *guide in guides) {
        [self.attachView removeLayoutGuide:guide];
    }
    [guides removeAllObjects];
}

- (void)active {
    [self active:self.leadingConstraints];
    [self active:self.trailingConstraints];
    [self active:self.leftConstraints];
    [self active:self.rightConstraints];
    [self active:self.topConstraints];
    [self active:self.bottomConstraints];
    [self active:self.widthConstraints];
    [self active:self.heightConstraints];
    [self active:self.centerXConstraints];
    [self active:self.centerYConstraints];
    [self active:self.firstBaselineConstraints];
    [self active:self.lastBaselineConstraints];
}

- (void)active:(NSArray *)constraints {
    for (BMLayoutConstraint *constraint in constraints) {
        constraint.systemConstraint.active = YES;
    }
}

- (void)setUp:(BMLayout *)layout {
    [self.leadingConstraints addObjectsFromArray:layout.leadingConstraints];
    [self.trailingConstraints addObjectsFromArray:layout.trailingConstraints];
    [self.leftConstraints addObjectsFromArray:layout.leftConstraints];
    [self.rightConstraints addObjectsFromArray:layout.rightConstraints];
    [self.topConstraints addObjectsFromArray:layout.topConstraints];
    [self.bottomConstraints addObjectsFromArray:layout.bottomConstraints];
    [self.widthConstraints addObjectsFromArray:layout.widthConstraints];
    [self.heightConstraints addObjectsFromArray:layout.heightConstraints];
    [self.centerXConstraints addObjectsFromArray:layout.centerXConstraints];
    [self.centerYConstraints addObjectsFromArray:layout.centerYConstraints];
    [self.firstBaselineConstraints addObjectsFromArray:layout.firstBaselineConstraints];
    [self.lastBaselineConstraints addObjectsFromArray:layout.lastBaselineConstraints];
}

- (void)printInfo {
    [self printInfo:self.leadingConstraints attach:@"leading"];
    [self printInfo:self.trailingConstraints attach:@"trailing"];
    [self printInfo:self.leftConstraints attach:@"left"];
    [self printInfo:self.rightConstraints attach:@"right"];
    [self printInfo:self.topConstraints attach:@"top"];
    [self printInfo:self.bottomConstraints attach:@"bottom"];
    [self printInfo:self.widthConstraints attach:@"width"];
    [self printInfo:self.heightConstraints attach:@"height"];
    [self printInfo:self.firstBaselineConstraints attach:@"firstBaseline"];
    [self printInfo:self.lastBaselineConstraints attach:@"lastBaseline"];
    [self printInfo:self.centerXConstraints attach:@"centerX"];
    [self printInfo:self.centerYConstraints attach:@"centerY"];
    NSLog(@"--------------------------------------------------------");
}

- (void)printInfo:(NSArray *)info attach:(NSString *)attachLabel {
    for (BMLayoutConstraint *c in info) {
        NSLog(@"%@ -- %@", attachLabel, c);
    }
}

#pragma mark - <BMLayoutProtocol>

- (UIView *)attachView {
    return self.view;
}

- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute {
    return [self getAnchor:attribute ofView:self.view];
}

- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute ofView:(UIView *)view {
    switch (attribute) {
        case NSLayoutAttributeLeading:       return view.leadingAnchor;
        case NSLayoutAttributeLeft:          return view.leftAnchor;
        case NSLayoutAttributeTrailing:      return view.trailingAnchor;
        case NSLayoutAttributeRight:         return view.rightAnchor;
        case NSLayoutAttributeTop:           return view.topAnchor;
        case NSLayoutAttributeBottom:        return view.bottomAnchor;
        case NSLayoutAttributeWidth:         return view.widthAnchor;
        case NSLayoutAttributeHeight:        return view.heightAnchor;
        case NSLayoutAttributeCenterX:       return view.centerXAnchor;
        case NSLayoutAttributeCenterY:       return view.centerYAnchor;
        case NSLayoutAttributeFirstBaseline: return view.firstBaselineAnchor;
        case NSLayoutAttributeLastBaseline:  return view.lastBaselineAnchor;
        default: {
            BMLayoutThrowTypeInvalidException
        } break;
    }
    return nil;
}

- (NSLayoutAnchor *)getAnchor:(NSLayoutAttribute)attribute ofGuide:(UILayoutGuide *)guide {
    switch (attribute) {
        case NSLayoutAttributeLeading:       return guide.leadingAnchor;
        case NSLayoutAttributeLeft:          return guide.leftAnchor;
        case NSLayoutAttributeTrailing:      return guide.trailingAnchor;
        case NSLayoutAttributeRight:         return guide.rightAnchor;
        case NSLayoutAttributeTop:           return guide.topAnchor;
        case NSLayoutAttributeBottom:        return guide.bottomAnchor;
        case NSLayoutAttributeWidth:         return guide.widthAnchor;
        case NSLayoutAttributeHeight:        return guide.heightAnchor;
        case NSLayoutAttributeCenterX:       return guide.centerXAnchor;
        case NSLayoutAttributeCenterY:       return guide.centerYAnchor;
        default: {
            BMLayoutThrowTypeInvalidException
        } break;
    }
    return nil;
}

- (BMLayout *)layout {
    return self;
}

- (NSArray *)getConstraints {
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:self.leadingConstraints];
    [array addObjectsFromArray:self.trailingConstraints];
    [array addObjectsFromArray:self.leftConstraints];
    [array addObjectsFromArray:self.rightConstraints];
    [array addObjectsFromArray:self.topConstraints];
    [array addObjectsFromArray:self.bottomConstraints];
    [array addObjectsFromArray:self.widthConstraints];
    [array addObjectsFromArray:self.heightConstraints];
    [array addObjectsFromArray:self.firstBaselineConstraints];
    [array addObjectsFromArray:self.lastBaselineConstraints];
    [array addObjectsFromArray:self.centerXConstraints];
    [array addObjectsFromArray:self.centerYConstraints];
    return array;
}

@end
