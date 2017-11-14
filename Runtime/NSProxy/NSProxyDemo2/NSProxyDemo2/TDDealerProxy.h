//
//  TDDealerProxy.h
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDBookProvider.h"
#import "TDClothesProvider.h"

@interface TDDealerProxy : NSProxy <TDBookProviderProtocol, TDClothesProviderProtocol>

+ (instancetype )dealerProxy;
@end
