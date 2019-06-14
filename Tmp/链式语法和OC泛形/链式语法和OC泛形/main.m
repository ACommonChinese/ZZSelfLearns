//
//  main.m
//  链式语法和OC泛形
//
//  Created by liuweizhen on 2019/6/14.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimalFactory.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        AnimalFactory
            .animal
            .eat(@"animal eat")
            .drink(@"animal drink")
            .think(@"animal think")
            .hit(@"animal hit");
        
        NSLog(@"-------------------------------");
        
        AnimalFactory
            .dog
            .eat(@"dog eat")
            .drink(@"dog drink")
            .think(@"dog think")
            .hit(@"dog hit");
        
        NSLog(@"-------------------------------");
        
        AnimalFactory
            .person
            .eat(@"person eat")
            .drink(@"person drink")
            .think(@"person think")
            .hit(@"person think");
        
        NSLog(@"-------------------------------");
        
        AnimalFactory
            .masterPerson
            .eat(@"masterPerson eat")
            .drink(@"masterPerson drink")
            .think(@"masterPerson think")
            .hit(@"masterPerson think")
            .masterThink(@"masterThink");
    }
    return 0;
}
