//
//  UserHttpHandler.h
//  NSProxyDemo_4_HttpProxy
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol UserHttpHandler <NSObject>

- (void)getUserWithID:(NSNumber *)userID;
@end
