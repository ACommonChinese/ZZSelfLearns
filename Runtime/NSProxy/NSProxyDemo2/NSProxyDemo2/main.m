//
//  main.m
//  NSProxyDemo2
//
//  Created by liuweizhen on 2017/11/12.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDDealerProxy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        TDDealerProxy *proxy = [TDDealerProxy dealerProxy];
        NSLog(@"address: %@", proxy);
        [proxy purchaseBookWithTitle:@"iOS Cook book"];
        [proxy purchaseClothesWithSize:TDClothesSizeMedium];
    }
    return 0;
}
