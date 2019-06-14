//
//  AnimalFactory.h
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "Animal.h"
#import "Dog.h"
#import "Person.h"
#import "MasterPerson.h"

NS_ASSUME_NONNULL_BEGIN

#define BM_GENERIC_2(TYPE) TYPE<TYPE *>
#define BM_GENERIC_3(TYPE) TYPE<TYPE<TYPE *> *>
#define BM_GENERIC_4(TYPE) TYPE<TYPE<TYPE<TYPE *> *> *>
#define BM_GENERIC_5(TYPE) TYPE<TYPE<TYPE<TYPE<TYPE *> *> *> *>
#define BM_GENERIC_6(TYPE) TYPE<TYPE<TYPE<TYPE<TYPE<TYPE *> *> *> *> *>
#define BM_GENERIC_7(TYPE) TYPE<TYPE<TYPE<TYPE<TYPE<TYPE<TYPE *> *> *> *> *> *>
#define BM_GENERIC_8(TYPE) TYPE<TYPE<TYPE<TYPE<TYPE<TYPE<TYPE<TYPE *> *> *> *> *> *> *>

@interface AnimalFactory : NSObject

//@property (nonatomic, weak, class, readonly) Animal<Animal *> *animal; // 3* can call 4 times
@property (nonatomic, weak, class, readonly) BM_GENERIC_8(Animal) *animal; // 如果不这样写，导致XCode不提示.语法，且无法编译通过

@property (nonatomic, weak, class, readonly) Dog *dog;
@property (nonatomic, weak, class, readonly) BM_GENERIC_8(Person) *person;
@property (nonatomic, weak, class, readonly) MasterPerson *masterPerson;

@end

NS_ASSUME_NONNULL_END
