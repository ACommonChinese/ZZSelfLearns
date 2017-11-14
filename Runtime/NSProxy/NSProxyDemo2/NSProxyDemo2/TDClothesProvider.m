//
//  TDClothesProvider.m
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "TDClothesProvider.h"

@implementation TDClothesProvider

- (void)purchaseClothesWithSize:(TDClothesSize )size{
    NSString *sizeStr;
    switch (size) {
        case TDClothesSizeLarge:
            sizeStr = @"large size";
            break;
        case TDClothesSizeMedium:
            sizeStr = @"medium size";
            break;
        case TDClothesSizeSmall:
            sizeStr = @"small size";
            break;
        default:
            break;
    }
    NSLog(@"You've bought some clothes of %@",sizeStr);
}

@end
