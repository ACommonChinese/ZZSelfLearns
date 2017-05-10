//
//  Student.h
//  1_TypeEncoding
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger age;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, readonly, assign) BOOL hidden;

- (void)printInfo;
- (instancetype)initWithKeyValues:(NSDictionary *)dict;

@end
