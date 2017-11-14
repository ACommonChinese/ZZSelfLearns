//
//  TDBookProvider.h
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TDBookProviderProtocol

- (void)purchaseBookWithTitle:(NSString *)bookTitle;
@end

@interface TDBookProvider : NSObject

@end
