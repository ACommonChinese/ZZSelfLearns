//
//  Student.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "Student.h"

@implementation Student

- (void)printInfo {
    NSLog(@"%@-%@-%ld-%lf", self.id, self.name, self.age, self.score);
    if (self.book) {
        [self.book printInfo];
    }
}

@end
