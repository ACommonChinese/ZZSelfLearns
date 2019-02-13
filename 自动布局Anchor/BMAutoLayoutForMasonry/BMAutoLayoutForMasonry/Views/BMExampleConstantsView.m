//
//  BMExampleConstantsView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/11.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleConstantsView.h"
#import "UIView+BMLayout.h"

@implementation BMExampleConstantsView


- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *purpleView = UIView.new;
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self addSubview:purpleView];
    
    UIView *orangeView = UIView.new;
    orangeView.backgroundColor = UIColor.orangeColor;
    orangeView.layer.borderColor = UIColor.blackColor.CGColor;
    orangeView.layer.borderWidth = 2;
    [self addSubview:orangeView];
    
    //example of using constants
    [purpleView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        CGFloat padding = 20;
        // [layout.top.left.bottom.right equal:@[@(padding), @(padding), @(-padding), @(-padding)]];
        [layout.edge equal:BMBox(UIEdgeInsetsMake(padding, padding, -padding, -padding))];
    }];
    [orangeView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.centerX equal:@(0)];
        [layout.centerY equal:@(0)];
        [layout.size equal:BMBox(CGSizeMake(200, 100))];
    }];
    
    return self;
}


@end
