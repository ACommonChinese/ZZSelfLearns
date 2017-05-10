//
//  Book.h
//  1_TypeEncoding
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) float price;
@property (nonatomic) NSString *author;

- (void)printInfo;

@end
