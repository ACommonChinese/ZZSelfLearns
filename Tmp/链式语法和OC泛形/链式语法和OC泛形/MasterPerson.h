//
//  MasterPerson.h
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "Person.h"

@class MasterPerson;
@interface MasterPerson : Person <MasterPerson *>

@property (nonatomic, weak, readonly) MasterPerson * (^masterThink)(NSString *str);

@end
