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
            unsigned int attributeOutCount;
            objc_property_attribute_t *attributies = property_copyAttributeList(property, &attributeOutCount);
            NSLog(@"-------------------------------------");
            for (NSInteger j = 0; j < attributeOutCount; j++) {
                objc_property_attribute_t attr = attributies[j];
                NSString *key = [[NSString alloc] initWithCString:attr.name encoding:NSUTF8StringEncoding];
                NSString *value = [[NSString alloc] initWithCString:attr.value encoding:NSUTF8StringEncoding];
                NSLog(@"%@-%@-%ld", key, value, value.length);
                // printf("%s-%s-%d\n", attr.name, attr.value, attr.value);
            }
        }
    }
    return self;
}

@end
