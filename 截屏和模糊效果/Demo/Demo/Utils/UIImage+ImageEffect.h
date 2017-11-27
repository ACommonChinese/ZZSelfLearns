//
//  UIImage+ImageEffect.h
//  GPUImageDemo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageEffect)

- (UIImage*)applyLightEffect;
- (UIImage*)applyExtraLightEffect;
- (UIImage*)applyDarkEffect;
- (UIImage*)applyTintEffectWithColor:(UIColor*)tintColor;
- (UIImage*)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor*)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage*)maskImage;
@end
