//
//  TestPerson.m
//  1_TypeEncoding
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "LBTest.h"
#import "Student.h"
#import "GoodStudent.h"
#import <objc/runtime.h>

@implementation LBTest

+ (void)test1 {
    Student *student = [[Student alloc] init];
    NSDictionary *dict = @{@"id"    : @"0000001",
                           @"name"  : @"刘威振",
                           @"age"   : @30,
                           @"score" : @100.0
                           };
    [student setValuesForKeysWithDictionary:dict];
    [student printInfo];
}

+ (void)test2 {
    GoodStudent *student = [[GoodStudent alloc] init];
    NSDictionary *studentDict = @{@"id"    : @"0000001",
                           @"name"  : @"刘威振",
                           @"age"   : @30,
                           @"score" : @100.0,
                           @"book"  : @{@"name" : @"iOS CookBook", @"price" : @56.8, @"author" : @"高斯林"}
                           };
    NSDictionary *bookDict = studentDict[@"book"];
    Book *book = [[Book alloc] init];
    [book setValuesForKeysWithDictionary:bookDict];
    [student setValuesForKeysWithDictionary:studentDict];
    student.book = book;
    [student printInfo];
}

+ (void)test3 {
    NSDictionary *dict = @{@"id"    : @"0000001",
                           @"name"  : @"刘威振",
                           @"age"   : @30,
                           @"score" : @100.0
                           };
    Student *student = [[Student alloc] initWithKeyValues:dict];
    [student printInfo];
}

@end
