//
//  BMCoordinatesInfo.h
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/25.
//  Copyright © 2018 banma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Repre
 */
@interface BMLocationCoordinate2D : NSObject <NSCopying>

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

+ (instancetype)coordinateWithLongitude:(double)longitude latitude:(double)latitude;

@end

@interface BMCoordinatesInfo : NSObject

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
@property (nonatomic, readonly) NSMutableArray<BMLocationCoordinate2D *> *screenCoordinates;

- (instancetype)initWithCoordinatesStr:(NSString *)coordinateStr
                                 width:(double)width
                                height:(double)height
                                margin:(UIEdgeInsets)marginInsets;

@end

NS_ASSUME_NONNULL_END
