//
//  Book.h
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Chapter.h"

@interface Book : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic) float price;
@property (nonatomic) NSString *author;
@property (nonatomic) NSArray *chapters;

- (void)printInfo;

@end
