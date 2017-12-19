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
//                           BMAlertController控制器                                //
/////////////////////////////////////////////////////////////////////////////////////

@interface BMAlertController : UIViewController

@property (nonatomic, weak) id<BMAlertControllerProtocol> delegate;

/// 构造器 - 使用customView对象
+ (BMAlertController *)alertControllerWithContentView:(UIView *)contentView;

/// 显示
- (void)show;

/// 隐藏
- (void)dismiss;

@end
