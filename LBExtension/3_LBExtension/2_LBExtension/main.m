//
//  main.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Student.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *chapters = @[@{@"title":@"第一章", @"content":@"第一章内容"}, @{@"title":@"第二章", @"content":@"第二章内容"}, @{@"title":@"第三章", @"content":@"第三章内容"}];
        NSDictionary *keyValues = @{@"id"    : @"0000001",
                                    @"name"  : @"刘威振",
                                    @"age"   : @30,
                                    @"score" : @100.0,
                                    @"book"  : @{@"name" : @"iOS CookBook", @"price" : @56.8, @"author" : @"高斯林", @"chapters" : chapters}
                                      };
        Student *student = [Student lb_objectWithKeyValues:keyValues];
        [student printInfo];
        
        NSDictionary *dict = [student lb_keyValues];
        NSLog(@"%@", dict);
    }
    return 0;
}
