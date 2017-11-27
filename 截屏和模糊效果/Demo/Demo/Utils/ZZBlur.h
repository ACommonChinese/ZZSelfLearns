//
//  ZZBlur.h
//  Demo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZZBlur : NSObject

+ (UIVisualEffectView *)getBlurViewWithFrame:(CGRect)frame;
+ (UIVisualEffectView *)getBlurViewWithView:(UIView *)view;
+ (UIVisualEffectView *)makeBlur:(UIView *)view;

@end
