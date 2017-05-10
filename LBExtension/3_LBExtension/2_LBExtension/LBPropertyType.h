//
//  LBPropertyType.h
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBFoundation.h"

@interface LBPropertyTypeBasic : NSObject

@end

@interface LBPropertyType : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) Class typeClass;

- (instancetype)initWithTypeName:(NSString *)typeName;
- (BOOL)isBasic; // 是否可以直接赋值
- (BOOL)isString;
- (BOOL)isMutableString;
- (BOOL)isArray;
- (BOOL)isMutableArray;
- (BOOL)isCustomObject;

@end
