///***************************************************************************************
// *
// *  Project:        ZXQ
// *
// *  Copyright ©     2014-2018年 DaLiu Technologies Co.,Ltd
// *                  All rights reserved.
// *
// *  This software is supplied only under the terms of a license agreement,
// *  nondisclosure agreement or other written agreement with DaLiu Technologies
// *  Co.,Ltd. Use, redistribution or other disclosure of any parts of this
// *  software is prohibited except in accordance with the terms of such written
// *  agreement with DaLiu Technologies Co.,Ltd. This software is confidential
// *  and proprietary information of DaLiu Technologies Co.,Ltd.
// *
// ***************************************************************************************
// *
// *  Header Name: UIView+BMSimpleLinear.m
// *
// *  General Description: Copyright and file header.
// *
// *  Created by liuweizhen on 2018/4/12.
// *
// *  liuxing8807@126.com
// *
// ****************************************************************************************/

#import "UIView+BMSimpleLinear.h"
#import <objc/runtime.h>

@interface BMConstraintShowInfo : NSObject

/// status: YES: show  NO: hidden
@property (nonatomic, assign) BOOL isShow;

@end

@implementation BMConstraintShowInfo
@end

@interface UIView ()

@property (nonatomic, strong) BMConstraintShowInfo *bm_showInfo;

@end

@implementation UIView (BMSimpleLinear)

- (void)setBm_linear:(BMSimpleLinear *)bm_linear {
    objc_setAssociatedObject(self, _cmd, bm_linear, OBJC_ASSOCIATION_RETAIN);
}

- (BMSimpleLinear *)bm_linear {
    BMSimpleLinear *linear = objc_getAssociatedObject(self, @selector(setBm_linear:));
    if (!linear) {
        self.bm_linear = linear = [[BMSimpleLinear alloc] init];
    }
    return linear;
}

- (void)bm_vSetPreviousSuper:(UIView *)superview {
    [self bm_vSetPreviousSuper:superview isSuperViewStatic:NO];
}

- (void)bm_vSetPreviousSuper:(UIView *)superview isSuperViewStatic:(BOOL)isStatic {
    if (!superview) {
        return;
    }
    BMSimpleLinearPrevious *previous = self.bm_linear.previous;
    if (!previous) {
        previous = [[BMSimpleLinearPrevious alloc] init];
        self.bm_linear.previous = previous;
    }
    previous.superview = superview;
    previous.marginTop = CGRectGetMinY(self.frame);
}

- (void)bm_vSetPrevious:(UIView *)view {
    NSAssert(view, @"bm_vSetPrevious: parameter view is nil");
 
    BMSimpleLinearPrevious *previous = self.bm_linear.previous;
    if (!previous) {
        previous = [[BMSimpleLinearPrevious alloc] init];
        self.bm_linear.previous = previous;
    }
    previous.view = view;
    previous.marginTop = CGRectGetMinY(self.frame) - CGRectGetMaxY(view.frame);
    [view bm_vSetNext:self];
}

- (void)bm_vSetNext:(UIView *)view {
    NSAssert(view, @"bm_vSetNext: parameter view is nil");

    BMSimpleLinearNext *next = self.bm_linear.next;
    if (!next) {
        next = [[BMSimpleLinearNext alloc] init];
        self.bm_linear.next = next;
    }
    next.view = view;
    next.marginBottom = CGRectGetMinY(view.frame) - CGRectGetMaxY(self.frame);
}

- (void)bm_vSetNextSuper:(UIView *)superview {
    [self bm_vSetNextSuper:superview isSuperViewStatic:NO];
}

- (void)bm_vSetNextSuper:(UIView *)superview isSuperViewStatic:(BOOL)isStatic {
    if (!superview) {
        return;
    }
    BMSimpleLinearNext *next = self.bm_linear.next;
    if (!next) {
        next = [[BMSimpleLinearNext alloc] init];
        self.bm_linear.next = next;
    }
    next.superview = superview;
    
    if ([superview isKindOfClass:[UIScrollView class]]) {
        next.marginBottom = 10;
    } else {
        next.marginBottom = superview.frame.size.height - CGRectGetMaxY(self.frame);
    }
}

// show it and it's top space
- (void)bm_vShow:(UIView *)subview {
    if (![self.subviews containsObject:subview] || !subview || !subview.isHidden) {
        return;
    }
    // 1. 计算出subview frame和偏移量
    // 2. 显示
    // 3. 其后所有可见视图origin.y增加相应偏移量
    // 4. 如果有父视图，改变父视图的尺寸
    CGRect frame = subview.frame;
    UIView *validPreviousView = [subview bm_vFindValidPreviousView];
    CGFloat marginTop = subview.bm_linear.previous.marginTop;
    CGFloat originY = marginTop;
    if (validPreviousView) {
        originY += CGRectGetMaxY(validPreviousView.frame);
    }
    else {
        originY = 0;
    }
    frame.origin.y = originY;
    subview.frame = frame;
    CGFloat moveLength = marginTop + frame.size.height;
    for (UIView *view in [subview bm_vFindValidNextViews]) {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y += moveLength;
        view.frame = viewFrame;
    }
    subview.hidden = NO;
    
    UIView *lastView = [subview bm_vFindValidCousinViews].lastObject;
    [self bm_resetWithLastValidSubview:lastView];
}

- (void)bm_resetWithLastValidSubview:(UIView *)lastSubview {
    if (!lastSubview) {
        [self bm_vChangeToHeight:0.0];
        return;
    }

    CGFloat marginBottom = lastSubview.bm_linear.next.marginBottom;
    CGFloat height = CGRectGetMaxY(lastSubview.frame) + marginBottom;
    if ([self isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrollView = (UIScrollView *)self;
        CGSize contentSize = scrollView.contentSize;
        contentSize.height = height;
        scrollView.contentSize = contentSize;
    } else {
        [self bm_vChangeToHeight:height];
    }
}

- (void)bm_vHidden:(UIView *)subview {
    if (![self.subviews containsObject:subview] || !subview || subview.isHidden) {
        // NSLog(@"⚠️ %s It's already hidden or not in the view-hierarchical", __func__);
        return;
    }
    
    // 1. 隐藏subview
    // 2. 计算出偏移量
    // 3. 其后所有可见视图origin.y减少相应偏移量
    // 4. 如果有父视图，改变父视图的尺寸
    subview.hidden = YES;
    CGFloat moveLength = subview.frame.size.height;
    NSArray *validNextViews = [subview bm_vFindValidNextViews];
    for (UIView *view in validNextViews) {
        CGRect frame = view.frame;
        frame.origin.y -= moveLength;
        view.frame = frame;
    }
    UIView *lastValidNextView = [subview bm_vFindValidCousinViews].lastObject;
    [self bm_resetWithLastValidSubview:lastValidNextView];
}

- (NSArray *)bm_vFindValidCousinViews {
    NSArray *validPrevious = [self bm_vFindValidPreviousViews];
    NSArray *validNexts = [self bm_vFindValidNextViews];
    NSMutableArray *array = [NSMutableArray array];
    [array addObjectsFromArray:validPrevious];
    if (!self.isHidden) {
        [array addObject:self];
    }
    [array addObjectsFromArray:validNexts];
    return array.count > 0 ? array : nil;
}

- (void)bm_vChangeToHeight:(CGFloat)height {
    // 1. 改变自身
    // 2. 计算出偏移量
    // 3. 其后所有可见视图origin.y增加相应偏移量
    // 4. 如果有父视图，改变其父视图的height
    CGRect frame = self.frame;
    
    // 如果缩小，moveLength为负值
    CGFloat moveLength = height - frame.size.height;
    frame.size.height = height;
    if ([self isKindOfClass:[UIScrollView class]]) {
        return;
    }
    self.frame = frame;
    
    // 改变其下堂兄视图
    for (UIView *view in [self bm_vFindValidNextViews]) {
        CGRect viewFrame = view.frame;
        viewFrame.origin.y += moveLength;
        view.frame = viewFrame;
    }

    UIView *lastView = [self bm_vFindValidCousinViews].lastObject;
    if (!lastView) {
        return;
    }
    if (lastView.bm_linear.next && lastView.bm_linear.next.superview) {
        UIView *superView = lastView.bm_linear.next.superview;
        if ([superView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)superView;
            CGSize contentSize = scrollView.contentSize;
            contentSize.height = CGRectGetMaxY(lastView.frame) + lastView.bm_linear.next.marginBottom;
            scrollView.contentSize = contentSize;
        }
        else {
            [superView bm_vChangeToHeight:CGRectGetMaxY(lastView.frame) + lastView.bm_linear.next.marginBottom];
        }
    }
}

- (UIView *)bm_vFindSuperView {
    UIView *lastView = [self bm_vFindLastNextView];
    if (!lastView) {
        lastView = self;
    }
    UIView *superview = lastView.bm_linear.next.superview;
    return superview;
}

- (void)bm_vHiddenCompletion:(BMSimpleLinearVHiddenType)completion lastView:(UIView *)lastView {
    if (completion) {
        completion(lastView);
    }
}

// 寻找上一个显示的view
- (UIView *)bm_vFindValidPreviousView {
    UIView *previousView = self.bm_linear.previous.view;
    if (!previousView) {
        return nil;
    }
    if (!previousView.isHidden) {
        return previousView;
    } else {
        return [previousView bm_vFindValidPreviousView];
    }
}

- (UIView *)bm_vFindLastValidPreviousView {
    return [self bm_vFindValidPreviousViews].lastObject;
}

// 寻找下一个显示的view
- (UIView *)bm_vFindValidNextView {
    UIView *nextView = self.bm_linear.next.view;
    if (!nextView) {
        return nil;
    }
    if (!nextView.isHidden) {
        return nextView;
    } else {
        return [nextView bm_vFindValidNextView];
    }
}

- (UIView *)bm_vFindLastValidNextView {
    return [self bm_vFindValidNextViews].lastObject;
}

// 寻找其后所有显示的view
- (NSArray *)bm_vFindValidNextViews {
    NSMutableArray *array = [NSMutableArray array];
    UIView *validNextView = self;
    while ((validNextView = [validNextView bm_vFindValidNextView])) {
        [array addObject:validNextView];
    }
    return array.count > 0 ? array : nil;
}

// 寻找其前所有显示的view
- (NSArray *)bm_vFindValidPreviousViews {
    NSMutableArray *array = [NSMutableArray array];
    UIView *validPreviousView = self;
    while ((validPreviousView = [validPreviousView bm_vFindValidPreviousView])) {
        [array addObject:validPreviousView];
    }
    if (array.count > 0) {
        return [[array reverseObjectEnumerator] allObjects];
    } else {
        return nil;
    }
}

- (UIView *)bm_vFindLastNextView {
    UIView *nextView = self.bm_linear.next.view;
    if (nextView.bm_linear.next.view) {
        return [nextView.bm_linear.next.view bm_vFindLastNextView];
    } else {
        return nextView;
    }
}

#pragma mark - For debug

- (void)setBm_identifier:(NSString *)bm_identifier {
    objc_setAssociatedObject(self, @selector(bm_identifier), bm_identifier, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)bm_identifier {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)bm_vPrintIdentifiers {
    NSArray *views = [self bm_vFindValidCousinViews];
    for (NSInteger i = 0; i < views.count; i++) {
        UIView *view = [views objectAtIndex:i];
        if (view.bm_identifier.length > 0) {
            NSLog(@"BMSimpleLinear log: %@", view.bm_identifier);
        }
    }
}

#pragma mark - For show & hidden in constraint Masonry system

- (void)setBm_showInfo:(BMConstraintShowInfo *)bm_showInfo {
    objc_setAssociatedObject(self, @selector(bm_showInfo), bm_showInfo, OBJC_ASSOCIATION_RETAIN);
}

- (BMConstraintShowInfo *)bm_showInfo {
    BMConstraintShowInfo *info = objc_getAssociatedObject(self, _cmd);
    return info;
}

- (BOOL)bm_vIsHidden {
    if (self.isHidden) return YES;
    if (!self.bm_showInfo) {
        return NO;
    }
    return !self.bm_showInfo.isShow;
}

@end
