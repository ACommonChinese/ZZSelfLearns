//
//  BMExampleAttributeChainingView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/13.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleAttributeChainingView.h"
#import "UIView+BMLayout.h"

@implementation BMExampleAttributeChainingView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIView *greenView = UIView.new;
    greenView.backgroundColor = UIColor.greenColor;
    greenView.layer.borderColor = UIColor.blackColor.CGColor;
    greenView.layer.borderWidth = 2;
    [self addSubview:greenView];
    
    UIView *redView = UIView.new;
    redView.backgroundColor = UIColor.redColor;
    redView.layer.borderColor = UIColor.blackColor.CGColor;
    redView.layer.borderWidth = 2;
    [self addSubview:redView];
    
    UIView *blueView = UIView.new;
    blueView.backgroundColor = UIColor.blueColor;
    blueView.layer.borderColor = UIColor.blackColor.CGColor;
    blueView.layer.borderWidth = 2;
    [self addSubview:blueView];
    
    UIView *superview = self;
    UIEdgeInsets padding = UIEdgeInsetsMake(15, 10, 15, 10);
    
    [greenView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top.left equal:superview].insets(padding);
        [layout.bottom equal:blueView.topAnchor].insets(padding);
        [layout.right equal:redView.leftAnchor].insets(padding);
        [layout.height equal:@[redView, blueView]];
    }];

    [redView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top.right equal:superview].insets(padding);
        [layout.left equal:greenView.rightAnchor].insets(padding);
        [layout.bottom equal:blueView.topAnchor].insets(padding);
        [layout.width equal:greenView.widthAnchor];
        [layout.height equal:@[greenView, blueView]];
    }];

    [blueView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top equal:greenView.bottomAnchor].insets(padding);
        [layout.left.right.bottom equal:superview].insets(padding);
        [layout.height equal:@[greenView, redView]];
    }];
    
    return self;
}

@end
