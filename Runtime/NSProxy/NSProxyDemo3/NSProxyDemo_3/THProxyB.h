//
//  THProxyB.h
//  NSProxyDemo_3
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THProxyB : NSObject
@property (nonatomic) id target;

- (instancetype)initWithObject:(id)object;
@end
