//
//  Animal.h
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animal;
@interface Animal<T> : NSObject

@property (nonatomic, weak, readonly) T (^eat)(NSString *str);
@property (nonatomic, weak, readonly) T (^drink)(NSString *str);
@property (nonatomic, weak, readonly) T (^think)(NSString *str);
@property (nonatomic, weak, readonly) T (^hit)(NSString *str);

@end

