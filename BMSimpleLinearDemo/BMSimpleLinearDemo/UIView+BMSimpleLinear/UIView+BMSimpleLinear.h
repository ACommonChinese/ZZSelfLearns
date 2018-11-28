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
// *  Header Name: UIView+BMSimpleLinear.h
// *
// *  General Description: Copyright and file header.
// *
// *  Created by liuweizhen on 2018/4/12.
// *
// *  liuxing8807@126.com
// *
// ****************************************************************************************/

#import <UIKit/UIKit.h>
#import "BMSimpleLinear.h"

typedef void (^BMSimpleLinearVHiddenType)(UIView *lastView);

// 在链表中的视图会发生变化，如果不允许发生变化就不可放入链表结构中
// scrollview不参与height的改变

@interface UIView (BMSimpleLinear)

#pragma mark - For show & hidden in frame system

@property (nonatomic, strong) BMSimpleLinear *bm_linear;

- (void)bm_vSetPrevious:(UIView *)view;
- (void)bm_vSetPreviousSuper:(UIView *)superview;
- (void)bm_vSetNextSuper:(UIView *)superview;
- (void)bm_vChangeToHeight:(CGFloat)height;
- (void)bm_vShow:(UIView *)subview;
- (void)bm_vHidden:(UIView *)subview;

#pragma mark - For debug in frame system

@property (nonatomic, copy) NSString *bm_identifier;

- (void)bm_vPrintIdentifiers;

@end
