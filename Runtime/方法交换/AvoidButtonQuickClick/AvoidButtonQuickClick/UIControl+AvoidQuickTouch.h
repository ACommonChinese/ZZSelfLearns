//
//  UIControl+AvoidQuickTouch.h
//  AvoidButtonQuickClick
//
//  Created by 刘威振 on 11/30/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (AvoidQuickTouch)

@property (nonatomic) NSTimeInterval minimumEventInterval; // 用以标识最短间隔时间

@end
