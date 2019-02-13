//
//  NSArray+BMAdditions.h
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BMLayout.h"

typedef NS_ENUM(NSUInteger, BMAxisType) {
    BMAxisTypeHorizontal,
    BMAxisTypeVertical
};

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (BMAdditions)

- (NSArray *)bm_makeLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block;
- (NSArray *)bm_updateLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block;
- (NSArray *)bm_remakeLayout:(void (NS_NOESCAPE ^)(BMLayout *layout))block;

/**
 *  distribute with fixed spacing
 *
 *  @param axisType     which axis to distribute items along
 *  @param fixedSpacing the spacing between each item
 *  @param leadSpacing  the spacing before the first item and the container
 *  @param tailSpacing  the spacing after the last item and the container
 */
- (void)bm_distributeViewsAlongAxis:(BMAxisType)axisType withFixedSpacing:(CGFloat)fixedSpacing leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

/**
 *  distribute with fixed item size
 *
 *  @param axisType        which axis to distribute items along
 *  @param fixedItemLength the fixed length of each item
 *  @param leadSpacing     the spacing before the first item and the container
 *  @param tailSpacing     the spacing after the last item and the container
 */
- (void)bm_distributeViewsAlongAxis:(BMAxisType)axisType withFixedItemLength:(CGFloat)fixedItemLength leadSpacing:(CGFloat)leadSpacing tailSpacing:(CGFloat)tailSpacing;

@end

NS_ASSUME_NONNULL_END
