//
//  HttpProxy.h
//  NSProxyDemo_4_HttpProxy
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHttpHandler.h"
#import "CommentHttpHandler.h"

@interface HttpProxy : NSProxy <UserHttpHandler, CommentHttpHandler>

+ (instancetype)sharedInstance;
- (void)registerHttpProtocol:(Protocol *)httpProtocol handler:(id)handler;
@end
