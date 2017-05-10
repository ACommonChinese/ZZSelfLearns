//
//  LBFoundation.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "LBFoundation.h"

static NSSet *_foundationClasses;

@implementation LBFoundation

+ (NSSet *)foundationClasses
{
    if (_foundationClasses == nil) {
        // 集合中没有NSObject，因为几乎所有的类都是继承自NSObject，具体是不是NSObject需要特殊判断
        _foundationClasses = [NSSet setWithObjects:
                              [NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSError class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSAttributedString class], nil];
    }
    return _foundationClasses;
}

+ (BOOL)isFoundationClass:(Class)cls {
    if (cls == NSObject.class) return YES;
    __block BOOL result = NO;
    [[self foundationClasses] enumerateObjectsUsingBlock:^(id  _Nonnull foundationClass, BOOL * _Nonnull stop) {
        if ([cls isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    return result;
}

@end
