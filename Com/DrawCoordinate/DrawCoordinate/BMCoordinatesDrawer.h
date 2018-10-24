//
//  BMCoordinatesDrawer.h
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 banma. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BMCoordinatesDrawerConfig : NSObject

@property (nonatomic, strong) NSString *coordinates;
@property (nonatomic, assign) double width;
@property (nonatomic, assign) double height;

@end

@interface BMCoordinatesDrawer : NSObject

- (UIImage *)drawImageWithConfig:(void (NS_NOESCAPE^)(BMCoordinatesDrawerConfig *config))config;

@end

NS_ASSUME_NONNULL_END
