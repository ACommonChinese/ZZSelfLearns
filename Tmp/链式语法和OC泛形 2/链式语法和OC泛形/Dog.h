//
//  Dog.h
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "Animal.h"

NS_ASSUME_NONNULL_BEGIN

@class Dog;
@interface Dog : Animal <Dog *>

@end

NS_ASSUME_NONNULL_END
