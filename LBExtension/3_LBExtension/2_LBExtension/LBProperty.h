//
//  LBProperty.h
//  LBExtension
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBPropertyType.h"
#import <objc/runtime.h>

@interface LBProperty : NSObject
@property (nonatomic, copy) NSString *varName;
@property (nonatomic) LBPropertyType *type;
@property (nonatomic) BOOL isReadOnly;

+ (instancetype)getLBProperty:(objc_property_t)objc_property;

@end
