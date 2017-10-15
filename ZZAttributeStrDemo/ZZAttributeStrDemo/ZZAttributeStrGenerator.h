//
//  ZZAttributeStrGenerator.h
//  ZZAttributeStrDemo
//
//  Created by liuweizhen on 2017/10/15.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZZAttributeStrItem : NSObject

@property (nonatomic, copy) NSString *string;
@property (nonatomic) NSDictionary *attributes;

+ (ZZAttributeStrItem *)itemWithStr:(NSString *)str attributes:(NSDictionary *)attributes;

@property (nonatomic, class, readonly) NSDictionary *testStyle;
@end


@interface ZZAttributeStrGenerator : NSObject

+ (NSAttributedString *)generateAttributedString:(NSArray<ZZAttributeStrItem *> *)itemList;
@end
