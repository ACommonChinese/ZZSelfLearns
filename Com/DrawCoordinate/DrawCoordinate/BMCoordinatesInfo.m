//
//  BMCoordinatesInfo.m
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/25.
//  Copyright © 2018 banma. All rights reserved.
//

#import "BMCoordinatesInfo.h"

@interface BMLocationCoordinate2D ()

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

@interface BMCoordinatesInfo ()

@property (nonatomic, assign) UIEdgeInsets marginInsets;

@end

@implementation BMCoordinatesInfo

- (instancetype)initWithCoordinatesStr:(NSString *)coordinateStr width:(double)width height:(double)height margin:(UIEdgeInsets)marginInsets {
    return [self initWithCoordinatesStr:coordinateStr width:width height:height margin:marginInsets pickStep:1];
}

- (instancetype)initWithCoordinatesStr:(NSString *)coordinateStr
                                 width:(double)width
                                height:(double)height
                                margin:(UIEdgeInsets)marginInsets
                              pickStep:(NSUInteger)pickStep {
    if (!coordinateStr || coordinateStr.length <= 0) {
        return nil;
    }
    if (self = [super init]) {
        NSArray *coordinates = [coordinateStr componentsSeparatedByString:@";"];
        if (pickStep != 1) {
            NSMutableArray *pickCoordinates = [[NSMutableArray alloc] initWithObjects:coordinates.firstObject, nil];
            for (NSInteger i = 1; i < coordinates.count; i++) {
                if (i % pickStep == 0) {
                    [pickCoordinates addObject:coordinates[i]];
                }
            }
            coordinates = pickCoordinates;
        }
        NSMutableArray *locations = [NSMutableArray arrayWithCapacity:coordinates.count];
        for (NSInteger i = 0; i < coordinates.count; i++) {
            NSString *coordinate  = coordinates[i];
            NSArray *location = [coordinate componentsSeparatedByString:@","];
            BMLocationCoordinate2D *location2D = [BMLocationCoordinate2D coordinateWithLongitude:[location.firstObject doubleValue] latitude:[location.lastObject doubleValue]];
            [locations addObject:location2D];
        }
        [self getInfoWithLocations:locations width:width height:height margin:marginInsets];
    }
    
    return self;
}

- (NSMutableArray<BMLocationCoordinate2D *> *)screenCoordinates {
    NSMutableArray<BMLocationCoordinate2D *> *screenCoordinates = [NSMutableArray arrayWithCapacity:self.coordinates.count];
    for (BMLocationCoordinate2D *coordinate in self.coordinates) {
        [screenCoordinates addObject:[BMLocationCoordinate2D coordinateWithLongitude:coordinate.longitude / self.scaleLongitude latitude:coordinate.latitude / self.scaleLatitude]];
    }
    if (!UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, self.marginInsets)) {
        [screenCoordinates enumerateObjectsUsingBlock:^(BMLocationCoordinate2D * _Nonnull coordinate, NSUInteger idx, BOOL * _Nonnull stop) {
            coordinate.longitude += self.marginInsets.left;
            coordinate.latitude += self.marginInsets.bottom;
        }];
    }
    return screenCoordinates;
}

- (void)getInfoWithLocations:(NSArray<BMLocationCoordinate2D *> *)locations width:(double)width height:(double)height margin:(UIEdgeInsets)marginInsets {
    self.marginInsets = marginInsets;
    
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
    NSAssert(width > marginInsets.left + marginInsets.right, @"margin horizonal is invalid. greater than canvas width");
    self.scaleLongitude = (self.maxLongitude - self.minLongitude) / (width - marginInsets.left - marginInsets.right);
    NSAssert(height > marginInsets.top + marginInsets.bottom, @"margin vertical is invalid. greater than canvas height");
    self.scaleLatitude = (self.maxLatitude - self.minLatitude) / (height - marginInsets.top - marginInsets.bottom);
}

- (void)dealloc {
    NSLog(@"BMCoordinatesInfo dealloc");
}

@end
