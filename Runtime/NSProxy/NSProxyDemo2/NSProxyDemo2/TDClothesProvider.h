//
//  TDClothesProvider.h
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSInteger, TDClothesSize){
    TDClothesSizeSmall = 0,
    TDClothesSizeMedium,
    TDClothesSizeLarge
};

@protocol TDClothesProviderProtocol

- (void)purchaseClothesWithSize:(TDClothesSize )size;

@end

@interface TDClothesProvider : NSObject

@end
