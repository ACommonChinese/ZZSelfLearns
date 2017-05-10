//
//  Student.m
//  1_TypeEncoding
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>

@implementation Student

- (void)printInfo {
    NSLog(@"%@-%@-%ld-%lf", self.id, self.name, self.age, self.score);
}

// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html
// https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
- (instancetype)initWithKeyValues:(NSDictionary *)dict {
    if (self = [super init]) {
        
        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        for (NSInteger i = 0; i < propertyCount; i++) {
            objc_property_t property = properties[i];
            NSLog(@"%s", property_getName(property));
            const char *attribute = property_getAttributes(property);
            printf("%s\n", attribute);
            /**
             T@"NSString",C,N,V_id // 对象 copy nonatomic
             T@"NSString",&,N,V_name // 对象 retain, nonatomic
             Tq,N,V_age // long long, nonatomic
             Td,N,V_score // double
             */
            NSString *propertyInfo = [[NSString alloc] initWithCString:attribute encoding:NSUTF8StringEncoding];
            NSString *lastElement = [[propertyInfo componentsSeparatedByString:@","] lastObject];
            NSString *varName = [lastElement substringFromIndex:2];
            id value = [dict valueForKey:varName];
            if (value) {
                [self setValue:[dict objectForKey:varName] forKey:varName];
            }
        }
    }
    return self;
}

@end
