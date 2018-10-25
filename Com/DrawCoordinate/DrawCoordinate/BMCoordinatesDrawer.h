//
//  BMCoordinatesDrawer.h
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Configuration for coordinates drawer
 */
@interface BMCoordinatesDrawerConfig : NSObject

/// coordinates texts, required
@property (nonatomic, strong) NSString *coordinates;

/// draw width, required
@property (nonatomic, assign) double width;

/// draw height, required
@property (nonatomic, assign) double height;

/// line stroke color, use white color as default
@property (nonatomic, strong) UIColor *lineColor;

/// line width, 2.0 as default
@property (nonatomic, assign) CGFloat lineWidth;

/// line cap
@property (nonatomic, assign) CGLineCap lineCap;

/// start point indicate color, red color as default
@property (nonatomic, strong) UIColor *startPointColor;

/// end point indicate color, blue color as default
@property (nonatomic, strong) UIColor *endPointColor;

/// start point radius, 5.0 as default
@property (nonatomic, assign) CGFloat startPointRadius;

/// end point radius, 5.0 as default
@property (nonatomic, assign) CGFloat endPointRadius;

/// margin inset for canvas, UIEdgeInsetsZero as default
@property (nonatomic, assign) UIEdgeInsets marginInsets;

@end

/**
 * Image drawer wieth given coordinates
 */
@interface BMCoordinatesDrawer : NSObject

/**
 * Draw UIImage with configuration
 *
 * @param config the configuration for drawer
 * @return instance of UIImage
 */
- (UIImage *)drawImageWithConfig:(void (NS_NOESCAPE^)(BMCoordinatesDrawerConfig *config))config;

@end

NS_ASSUME_NONNULL_END
