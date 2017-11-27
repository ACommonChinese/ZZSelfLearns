//
//  ZZBlur.m
//  Demo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZBlur.h"
#import "ZZScreenShot.h"

@implementation ZZBlur

+ (UIVisualEffectView *)getBlurViewWithFrame:(CGRect)frame {
    // Noted: iOS8 & Later
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    // 毛玻璃视图
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    // 添加到要有毛玻璃特效的控件中
    effectView.frame = frame;
    return effectView;
}

+ (UIVisualEffectView *)getBlurViewWithView:(UIView *)view {
    return [self getBlurViewWithFrame:view.bounds];
}

+ (UIVisualEffectView *)makeBlur:(UIView *)view {
    UIVisualEffectView *blurView = [self getBlurViewWithView:view];
    [view addSubview:blurView];
    return blurView;
}

@end
