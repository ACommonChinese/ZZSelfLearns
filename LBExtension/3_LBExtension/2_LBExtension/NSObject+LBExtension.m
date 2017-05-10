//
//  NSObject+LBExtension.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "NSObject+LBExtension.h"
#import "LBProperty.h"
#import <objc/runtime.h>

@implementation NSObject (LBExtension)

// Convert Data/String -> Dictionary/Array
- (id)lb_JSONObject {
    if ([self isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    } else {
        return self;
    }
}

// Convert key-values to Model
+ (instancetype)lb_objectWithKeyValues:(id)keyValues {
    NSDictionary *dict = [keyValues lb_JSONObject];
    return [[[self alloc] init] lb_setKeyValues:dict];
}

+ (NSMutableArray *)lb_objectArrayWithKeyValuesArray:(id)keyValuesArray {
    NSArray *array = [keyValuesArray lb_JSONObject];
    if (self == [NSString class] || self == [NSNumber class]) {
        return [NSMutableArray arrayWithArray:array];
    }
    NSMutableArray *mArray = [NSMutableArray array];
    for (id obj in keyValuesArray) {
        [mArray addObject:[self lb_objectWithKeyValues:obj]];
    }
    return mArray;
}

+ (NSDictionary *)lb_objectClassInArray {
    return nil;
}

// 核心代码
- (instancetype)lb_setKeyValues:(id)keyValues {
    for (LBProperty *property in self.properties) {
        if (property.isReadOnly) continue;
        id value = [keyValues objectForKey:property.varName];
        if (!value || ((property.type.isMutableString || property.type.isString) && [value isEqualToString:@"null"])) continue;
        // 基本类型，可以直接赋值
        // ...
        
        // 数组
        if (property.type.isArray || property.type.isMutableArray) {
            if ([[self class] respondsToSelector:@selector(lb_objectClassInArray)]) {
                NSDictionary *dict = [[self class] lb_objectClassInArray];
                if (!dict) continue;
                Class itemCls = [dict objectForKey:property.varName];
                value = [itemCls lb_objectArrayWithKeyValuesArray:value];
            }
        } else if (property.type.isCustomObject) {
            // TODO:// 复杂类型处理，example: NSURL
            // ...
            value = [property.type.typeClass lb_objectWithKeyValues:value];
        }
        
        // 特殊处理之 可变-->不可变
        if (property.type.isMutableString) {
            value = [NSMutableString stringWithString:value];
        } else if (property.type.isMutableArray) {
            value = [NSMutableArray arrayWithArray:value];
        }
        [self setValue:value forKey:property.varName];
    }
    return self;
}

// Convert model to key-values
- (NSMutableDictionary *)lb_keyValues {
    if ([LBFoundation isFoundationClass:[self class]]) return (NSMutableDictionary *)self;
    NSMutableDictionary *keyValues = [NSMutableDictionary dictionaryWithCapacity:self.properties.count];
    for (LBProperty *property in self.properties) {
        id value = [self valueForKey:property.varName];
        if (!value) continue;
        if (property.type.isCustomObject) {
            value = [value lb_keyValues];
        } else if (property.type.isArray || property.type.isMutableArray) {
            NSMutableArray *mArray = [self lb_keyValuesArrayWithObjectArray:value];
            value = mArray;
        }
        keyValues[property.varName] = value;
    }
    return keyValues;
}

- (NSMutableArray *)lb_keyValuesArrayWithObjectArray:(NSArray *)objectArray {
    NSMutableArray *mArray = [NSMutableArray arrayWithCapacity:objectArray.count];
    for (id obj in objectArray) {
        [mArray addObject:[obj lb_keyValues]];
    }
    return mArray;
}

- (NSArray<LBProperty *> *)properties {
    NSArray<LBProperty *> *propertyList = objc_getAssociatedObject(self, _cmd);
    if (!propertyList) {
        unsigned int propertyCount = 0;
        objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:propertyCount];
        for (NSInteger i = 0; i < propertyCount; i++) {
            objc_property_t p = properties[i];
            [array addObject:[LBProperty getLBProperty:p]];
        }
        self.properties = array;
        return self.properties;
    }
    return propertyList;
}

- (void)setProperties:(NSArray<LBProperty *> *)properties {
    objc_setAssociatedObject(self, @selector(properties), properties, OBJC_ASSOCIATION_RETAIN);
}

@end
