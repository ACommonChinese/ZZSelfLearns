//
//  Student.h
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+LBExtension.h"
#import "Book.h"

@interface Student : NSObject

@property (nonatomic, copy) NSString *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSInteger age;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic) Book *book;

- (void)printInfo;

@end
