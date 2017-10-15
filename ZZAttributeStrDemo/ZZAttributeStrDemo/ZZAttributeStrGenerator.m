//
//  ZZAttributeStrGenerator.m
//  ZZAttributeStrDemo
//
//  Created by liuweizhen on 2017/10/15.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ZZAttributeStrGenerator.h"

static NSDictionary *_testStyle;

@implementation ZZAttributeStrItem

+ (ZZAttributeStrItem *)itemWithStr:(NSString *)str attributes:(NSDictionary *)attributes {
    ZZAttributeStrItem *item = [[ZZAttributeStrItem alloc] init];
    item.string              = str;
    item.attributes          = attributes;
    return item;
}

+ (ZZAttributeStrItem *)itemWithStr:(NSString *)str font:(UIFont *)font color:(UIColor *)color {
    return [self itemWithStr:str attributes:@{NSFontAttributeName : font, NSForegroundColorAttributeName : color}];
}

+ (NSDictionary *)testStyle {
    if (_testStyle == nil) {
        UIFont *font = [UIFont fontWithName:@"Courier" size:38.0];
        NSShadow *shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 10;  // 模糊度
        shadow.shadowColor = [UIColor blackColor];
        shadow.shadowOffset = CGSizeMake(5, 8);
        NSDictionary *attriDict = @{
                 NSFontAttributeName : font,
                 NSUnderlineStyleAttributeName : @1,
                 NSUnderlineColorAttributeName : [UIColor redColor],
                 // NSStrikethroughStyleAttributeName : @2,
                 // NSStrikethroughColorAttributeName : [UIColor blueColor],
                 NSForegroundColorAttributeName : [UIColor blueColor],
                 // NSStrokeWidthAttributeName : @5,
                 NSShadowAttributeName : shadow,
                 NSObliquenessAttributeName : @0.5};
        _testStyle = attriDict;
    }
    return _testStyle;
}

@end

@implementation ZZAttributeStrGenerator

+ (NSAttributedString *)generateAttributedString:(NSArray<ZZAttributeStrItem *> *)itemList {
    if (itemList.count <= 0) return nil;
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] init];
    [itemList enumerateObjectsUsingBlock:^(ZZAttributeStrItem * item, NSUInteger idx, BOOL * _Nonnull stop) {
        NSAssert(item.string, @"The ZZAttributeStrItem.string property should be no-null");
        NSAttributedString *str = [[NSAttributedString alloc] initWithString:item.string attributes:item.attributes];
        [attributedStr appendAttributedString:str];
    }];
    return attributedStr.copy;
}



@end
