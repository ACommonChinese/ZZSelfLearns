//
//  Chapter.h
//  2_LBExtension
//
//  Created by liuweizhen on 2017/5/10.
//  Copyright © 2017年 刘威振. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

- (void)printInfo;

@end

