//
//  BMCoordinatesDrawer.m
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 banma. All rights reserved.
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

/**
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

@interface BMLocationCoordinate2D : NSObject <NSCopying>

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

+ (instancetype)coordinateWithLongitude:(double)longitude latitude:(double)latitude;

@end

@implementation BMLocationCoordinate2D

+ (instancetype)coordinateWithLongitude:(double)longitude latitude:(double)latitude {
    BMLocationCoordinate2D *location = BMLocationCoordinate2D.new;
    location.longitude = longitude;
    location.latitude = latitude;
    return location;
}

- (id)copyWithZone:(nullable NSZone *)zone {
    BMLocationCoordinate2D *coordinate = [[[self class] alloc] init];
    coordinate.longitude = self.longitude;
    coordinate.latitude = self.latitude;
    return coordinate;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%lf -- %lf", self.longitude, self.latitude];
}

@end

@interface BMCoordinateLocationInfo : NSObject

/// 经度最小值
@property (nonatomic, assign) double minLongitude;

/// 纬度最小值
@property (nonatomic, assign) double minLatitude;

/// 经度最大值
@property (nonatomic, assign) double maxLongitude;

/// 纬度最大值
@property (nonatomic, assign) double maxLatitude;

/// 经度缩放比例
@property (nonatomic, assign) double scaleLongitude;

/// 纬度缩放比例
@property (nonatomic, assign) double scaleLatitude;

/// 经纬度坐标点
@property (nonatomic, strong) NSMutableArray<BMLocationCoordinate2D *> *coordinates;

/// 经纬度坐标点
@property (nonatomic, strong) NSMutableArray<BMLocationCoordinate2D *> *screenCoordinates;

- (instancetype)initWithCoordinatesStr:(NSString *)coordinateStr width:(double)width height:(double)height;

@end

@implementation BMCoordinateLocationInfo

- (instancetype)initWithCoordinatesStr:(NSString *)coordinateStr width:(double)width height:(double)height {
    if (!coordinateStr || coordinateStr.length <= 0) {
        return nil;
    }
    if (self = [super init]) {
        NSArray *coordinates = [coordinateStr componentsSeparatedByString:@";"];
        NSMutableArray *locations = [NSMutableArray arrayWithCapacity:coordinates.count];
        // NSLog(@"--------------  %@", coordinates);
        for (NSInteger i = 0; i < coordinates.count; i++) {
            NSString *coordinate  = coordinates[i];
            NSArray *location = [coordinate componentsSeparatedByString:@","];
            BMLocationCoordinate2D *location2D = [BMLocationCoordinate2D coordinateWithLongitude:[location.firstObject doubleValue] latitude:[location.lastObject doubleValue]];
            [locations addObject:location2D];
        }
        [self getInfoWithLocations:locations width:width height:height];
    }
    return self;
}

- (void)getInfoWithLocations:(NSArray<BMLocationCoordinate2D *> *)locations width:(double)width height:(double)height {
    BMLocationCoordinate2D *firstLocation = locations[0];
    double minLongitude = firstLocation.longitude;
    double minLatitude  = firstLocation.latitude;
    double maxLongitude = firstLocation.longitude;
    double maxLatitude  = firstLocation.latitude;
    for (BMLocationCoordinate2D *coordinate in locations) {
        if (coordinate.longitude < minLongitude) {
            minLongitude = coordinate.longitude;
        }
        if (coordinate.longitude > maxLongitude) {
            maxLongitude = coordinate.longitude;
        }
        if (coordinate.latitude < minLatitude) {
            minLatitude = coordinate.latitude;
        }
        if (coordinate.latitude > maxLatitude) {
            maxLatitude = coordinate.latitude;
        }
    }
    
    double vectorLongitude = -minLongitude;
    double vectorLatitude = -minLatitude;
    
    NSArray *coordinates = [locations copy];
    for (BMLocationCoordinate2D *coordinate in coordinates) {
        coordinate.longitude += vectorLongitude;
        coordinate.latitude += vectorLatitude;
    }
    self.coordinates  = [NSMutableArray arrayWithArray:coordinates];
    self.minLongitude = MAX(0, minLongitude + vectorLongitude);
    self.minLatitude  = MAX(0, minLatitude + vectorLatitude);
    self.maxLongitude = MAX(0, maxLongitude + vectorLongitude);
    self.maxLatitude  = MAX(0, maxLatitude + vectorLatitude);
    self.scaleLongitude = (self.maxLongitude - self.minLongitude) / width;
    self.scaleLatitude = (self.maxLatitude - self.minLatitude) / height;
    NSMutableArray<BMLocationCoordinate2D *> *screenCoordinates = [NSMutableArray arrayWithCapacity:self.coordinates.count];
    for (BMLocationCoordinate2D *coordinate in self.coordinates) {
        [screenCoordinates addObject:[BMLocationCoordinate2D coordinateWithLongitude:coordinate.longitude / self.scaleLongitude latitude:coordinate.latitude / self.scaleLatitude]];
    }
    self.screenCoordinates = screenCoordinates;
}

@end

@interface BMCoordinatesDrawer ()

@property (nonatomic, strong) BMCoordinateLocationInfo *coordinateInfo;

@end

@implementation BMCoordinatesDrawerConfig

- (instancetype)init {
    if (self = [super init]) {
        // Set the default value here, such as color, line width, etc...
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
    
    self.coordinateInfo = [[BMCoordinateLocationInfo alloc] initWithCoordinatesStr:config.coordinates width:config.width height:config.height];
    
    UIGraphicsBeginImageContext(CGSizeMake(config.width, config.height));
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, config.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetLineWidth(context, 2);
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    CGContextSetRGBStrokeColor(context, 0.5,0, 0.8, 1.0);
    NSArray *screenCoordinates = self.coordinateInfo.screenCoordinates;
    NSLog(@"%@", screenCoordinates);
    
    CGPoint points[screenCoordinates.count];
    for (NSInteger i = 0; i < screenCoordinates.count; i++) {
        BMLocationCoordinate2D *coordinate = screenCoordinates[i];
        points[i] = CGPointMake(coordinate.longitude, coordinate.latitude);
    }
    CGContextAddLines(context, points, screenCoordinates.count);
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

@end
