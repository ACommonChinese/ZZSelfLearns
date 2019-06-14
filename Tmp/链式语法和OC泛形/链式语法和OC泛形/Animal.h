//
//  Animal.h
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Animal;
@interface Animal<AnimalType> : NSObject

@property (nonatomic, weak, readonly) AnimalType (^eat)(NSString *str);
@property (nonatomic, weak, readonly) AnimalType (^drink)(NSString *str);
@property (nonatomic, weak, readonly) AnimalType (^think)(NSString *str);
@property (nonatomic, weak, readonly) AnimalType (^hit)(NSString *str);

@end

