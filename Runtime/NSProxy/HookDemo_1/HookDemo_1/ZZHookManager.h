//
//  ZZHookManager.h
//  HookDemo_2
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZHookManager : NSObject

+ (void)hookObject:(id)object method:(SEL)method toObject:(id)toObject toMethod:(SEL)toMethod;
@end
