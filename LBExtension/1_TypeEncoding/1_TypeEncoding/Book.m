//
//  Book.m
//  1_TypeEncoding
//
//  Created by liuweizhen on 2017/5/9.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)printInfo {
    NSLog(@"book_name: %@ book_price: %lf book_author: %@", self.name, self.price, self.author);
}

@end
