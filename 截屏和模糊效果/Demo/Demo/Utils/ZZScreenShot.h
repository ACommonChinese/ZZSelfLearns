//
//  ZZScreenShot.h
//  Demo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface ZZScreenShot : NSObject

+ (UIImage *)getScreenShotForView:(UIView *)view;
+ (UIImage *)getScreenShotForView:(UIView *)view size:(CGSize)size;

@end
