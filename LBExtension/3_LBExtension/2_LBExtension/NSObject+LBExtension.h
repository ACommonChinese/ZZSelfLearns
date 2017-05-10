//
//  NSObject+LBExtension.h
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBProperty.h"

@interface NSObject (LBExtension)

@property (nonatomic) NSArray<LBProperty *> *properties;

/** Convert key-values to Model */
+ (instancetype)lb_objectWithKeyValues:(id)keyValues;

/** Convert key-value array to model array */
+ (NSMutableArray *)lb_objectArrayWithKeyValuesArray:(id)keyValuesArray;

/** Convert model to key-values */
- (NSMutableDictionary *)lb_keyValues;

/** Convert model array to key-values */
- (NSMutableArray *)lb_keyValuesArrayWithObjectArray:(NSArray *)objectArray;


/**
 *  数组中需要转换的模型类
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)lb_objectClassInArray;

@end
