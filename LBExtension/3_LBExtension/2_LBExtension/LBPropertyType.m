//
//  LBPropertyType.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "LBPropertyType.h"

@implementation LBPropertyTypeBasic

@end

@interface LBPropertyType()

@property (nonatomic) NSDictionary *typeDictionary;
@end

@implementation LBPropertyType

- (instancetype)initWithTypeName:(NSString *)typeName {
    self = [super init];
    if ([typeName hasPrefix:@"@"]) {
        typeName = [typeName substringWithRange:NSMakeRange(2, typeName.length-3)];
        self.name = typeName;
        self.typeClass = NSClassFromString(typeName);
    } else {
        self.name = typeName;
        self.typeClass = [LBPropertyTypeBasic class];
    }
    return self;
}

- (BOOL)isBasic {
    return self.typeClass == LBPropertyTypeBasic.class || [@[[NSString class], [NSNumber class]] containsObject:self.typeClass];
}

- (BOOL)isString {
    return self.typeClass == NSString.class;
}

- (BOOL)isMutableString {
    return self.typeClass == NSMutableString.class;
}

- (BOOL)isArray {
    return self.typeClass == NSArray.class;
}

- (BOOL)isMutableArray {
    return self.typeClass == NSMutableArray.class;
}

- (BOOL)isCustomObject {
    return !(LBPropertyTypeBasic.class == self.typeClass) && ![LBFoundation isFoundationClass:self.typeClass];
}

@end
