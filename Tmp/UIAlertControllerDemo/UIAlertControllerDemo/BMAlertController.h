//
//  BMAlertController.h
//  UIAlertControllerDemo
//
//  Created by banma-623 on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

/////////////////////////////////////////////////////////////////////////////////////
//                     BMAlertController协议 - 显示或消失回调                        //
/////////////////////////////////////////////////////////////////////////////////////

@class BMAlertController;

/** BM弹框控制器 */
@protocol BMAlertControllerProtocol<NSObject>

/**
 *  显示动画结束后回调
 *  @param controller BMAlertController对象
 */
- (void)alertControllerDidShow:(BMAlertController *)controller;

/**
 *  结束动画即将结束回调
 *  @param controller BMAlertController对象
 */
- (void)alertControllerWillDismiss:(BMAlertController *)controller;
@end

/////////////////////////////////////////////////////////////////////////////////////
//                           BMAlertController配置类                               //
/////////////////////////////////////////////////////////////////////////////////////

@interface BMAlertControllerConfig : NSObject

/// 头部label
@property (nonatomic, readonly) UILabel *titleLabel;

@property (nonatomic, readonly) UITextView *messageTextView;
/// 弹框默认宽
@property (nonatomic) CGFloat defaultWidth;
/// 圆角
@property (nonatomic) CGFloat cornerRadius;
/// 交互Buttons
@property (nonatomic) NSArray<UIButton *> *actionButtons;
@end

/////////////////////////////////////////////////////////////////////////////////////
//                           BMAlertController控制器                                //
/////////////////////////////////////////////////////////////////////////////////////

@interface BMAlertController : UIViewController

/// 构造器 - 使用BMAlertControllerConfig对象
+ (BMAlertController *)alertControllerWithConfig:(BMAlertControllerConfig *)config;

/// 构造器 - 使用customView对象
+ (BMAlertController *)alertControllerWithCustomView:(UIView *)customView;

/// 显示
- (void)show;

/// 隐藏
- (void)dismiss;

@end
