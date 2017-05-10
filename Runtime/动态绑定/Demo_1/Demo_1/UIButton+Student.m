//
//  UIButton+Student.m
//  Demo_1
//
//  Created by 刘威振 on 4/19/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "UIButton+Student.h"
#import <objc/runtime.h>

@implementation UIButton (Student)

/**
- (void)setStudent:(Student *)student {
    objc_setAssociatedObject(self, "student_key", student, OBJC_ASSOCIATION_RETAIN);
}

- (Student *)student {
    return objc_getAssociatedObject(self, "student_key");
}*/

- (void)setStudent:(Student *)student {
    objc_setAssociatedObject(self, @selector(student), student, OBJC_ASSOCIATION_RETAIN);
}

- (Student *)student {
    return objc_getAssociatedObject(self, _cmd);
}

@end
