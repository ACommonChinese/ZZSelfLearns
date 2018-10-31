//
//  BMCoordinatesDrawer.m
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//

/**
 * 111.690605,40.811581
 *
 * 经纬度转十进制：57°55’56.6″ = 57+55/60+56.6/3600=57.9323888888888
 *
 * 十进制转经纬度：
 * 57.9323888888888 = 57度
 * 0.9323888888888 * 60 = 55.943333333328  55分
 * 0.943333333328 * 60 = 56.599999999679994   约56.6秒
 */

/** 坐标转换后：
 Y 纬度 latitude
 |
 |
 |
 |
 |
 |
 |
 |
 |
 --------------------------- X 经度 longitude
 */

/**
 * 1. 点 (最小经度minLongitude，最小纬度minLatitude)
 * 2. 点 (最大经度maxLongitude，最大纬度maxLatitude)
 * 3. 计算出向量vector，并重置点
 * 4. 计算出比例, scaleX, scaleY
 * 5. 根据经纬度点计算出屏幕点
 * 6. 连点为线
 */

#import "BMCoordinatesDrawer.h"
#import "BMCoordinatesInfo.h"

@interface BMCoordinatesDrawer ()

@property (nonatomic, strong) BMCoordinatesInfo *coordinateInfo;

@end

@implementation BMCoordinatesDrawerConfig

- (instancetype)init {
    if (self = [super init]) {
        self.lineColor        = [UIColor whiteColor];
        self.lineWidth        = 2.0;
        self.lineCap          = kCGLineCapRound;
        self.startPointColor  = [UIColor redColor];
        self.endPointColor    = [UIColor blueColor];
        self.startPointRadius = 5.0;
        self.endPointRadius   = 5.0;
        self.marginInsets     = UIEdgeInsetsZero;
        self.pickStep         = 1;
        // etc...
    }
    return self;
}

@end

@implementation BMCoordinatesDrawer

- (UIImage *)drawImageWithConfig:(void (NS_NOESCAPE^)(BMCoordinatesDrawerConfig *config))configBlock {
    BMCoordinatesDrawerConfig *config = [[BMCoordinatesDrawerConfig alloc] init];
    if (configBlock) {
        configBlock(config);
    }
    if (config.width <= 0 || config.height <= 0 || !config.coordinates || config.coordinates.length <= 0) {
        return nil;
    }
    
    config.width -= (config.marginInsets.left + config.marginInsets.right);
    config.height -= (config.marginInsets.top + config.marginInsets.bottom);
    
    self.coordinateInfo = [[BMCoordinatesInfo alloc] initWithCoordinatesStr:config.coordinates width:config.width height:config.height margin:config.marginInsets pickStep:config.pickStep];
    
    UIGraphicsBeginImageContext(CGSizeMake(config.width, config.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, config.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextSetLineWidth(context, config.lineWidth);
    CGContextSetLineCap(context, config.lineCap);
    CGContextSetStrokeColorWithColor(context, config.lineColor.CGColor);
    
    NSArray *screenCoordinates = self.coordinateInfo.screenCoordinates;
    CGPoint points[screenCoordinates.count];
    for (NSInteger i = 0; i < screenCoordinates.count; i++) {
        BMLocationCoordinate2D *coordinate = screenCoordinates[i];
        points[i] = CGPointMake(coordinate.longitude, coordinate.latitude);
    }
    CGContextAddLines(context, points, screenCoordinates.count);
    CGContextStrokePath(context);
    
    BMLocationCoordinate2D *startCoordinate = screenCoordinates.firstObject;
    CGContextSetFillColorWithColor(context, config.startPointColor.CGColor);
    CGContextAddArc(context, startCoordinate.longitude, startCoordinate.latitude, config.startPointRadius, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    BMLocationCoordinate2D *endCoordinate = screenCoordinates.lastObject;
    CGContextSetFillColorWithColor(context, config.endPointColor.CGColor);
    CGContextAddArc(context, endCoordinate.longitude, endCoordinate.latitude, config.endPointRadius, 0, 2*M_PI, 0);
    CGContextDrawPath(context, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.coordinateInfo = nil;
    
    return image;
}

@end
