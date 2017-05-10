//
//  Book.m
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import "Book.h"

@implementation Book

- (void)printInfo {
    NSLog(@"book_name: %@ book_price: %lf book_author: %@", self.name, self.price, self.author);
    for (Chapter *chapter in self.chapters) {
        [chapter printInfo];
    }
}

+ (NSDictionary *)lb_objectClassInArray {
    return @{@"chapters" : [Chapter class]};
}

@end
