//
//  ZZScreenShot.m
//  Demo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZScreenShot.h"

@implementation ZZScreenShot

+ (UIImage *)getScreenShotForView:(UIView *)view {
    return [self getScreenShotForView:view size:view.bounds.size];
}

+ (UIImage *)getScreenShotForView:(UIView *)view size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (size.width < view.bounds.size.width || size.height < view.bounds.size.height) {
        img = [self createImageWithImage:img size:size];
    }
    return img;
}

+ (UIImage *)createImageWithImage:(UIImage *)image size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0.0f, size.height);
    CGContextScaleCTM(context, 1.0, -1.0); // http://blog.csdn.net/hamasn/article/details/8244073
    CGContextDrawImage(context, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

@end
