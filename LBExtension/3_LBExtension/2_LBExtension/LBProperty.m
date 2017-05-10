//
//  LBProperty.m
//  LBExtension
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "LBProperty.h"

@implementation LBProperty

+ (instancetype)getLBProperty:(objc_property_t)objc_property {
    LBProperty *property = [[LBProperty alloc] init];
    
    // varName
    property.varName = [[NSString alloc] initWithCString:property_getName(objc_property) encoding:NSUTF8StringEncoding];
    
    unsigned int attributeOutCount;
    objc_property_attribute_t *attributies = property_copyAttributeList(objc_property, &attributeOutCount);
    NSMutableDictionary *attriDict = [NSMutableDictionary dictionaryWithCapacity:attributeOutCount];
    for (NSInteger j = 0; j < attributeOutCount; j++) {
        objc_property_attribute_t attr = attributies[j];
        NSString *key = [[NSString alloc] initWithCString:attr.name encoding:NSUTF8StringEncoding];
        NSString *value = [[NSString alloc] initWithCString:attr.value encoding:NSUTF8StringEncoding];
        // NSLog(@"%@-%@-%ld", key, value, value.length);
        // printf("%s-%s-%d\n", attr.name, attr.value, attr.value);
        [attriDict setValue:value forKey:key];
    }
    
    // type
    NSString *typeName = [attriDict valueForKey:@"T"];
    LBPropertyType *type = [[LBPropertyType alloc] initWithTypeName:typeName];
    property.type = type;
    
    if ([attriDict valueForKey:@"R"]) {
        // isReadOnly
        property.isReadOnly = YES;
    }
    free(attributies);
    return property;
}

@end
