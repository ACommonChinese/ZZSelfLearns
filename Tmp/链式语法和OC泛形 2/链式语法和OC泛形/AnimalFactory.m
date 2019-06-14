//
//  AnimalFactory.m
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "AnimalFactory.h"

@implementation AnimalFactory

+ (Animal *)animal {
    return Animal.new;
}

+ (Dog *)dog {
    return Dog.new;
}

+ (Person *)person {
    return Person.new;
}

+ (MasterPerson *)masterPerson {
    return MasterPerson.new;
}

@end
