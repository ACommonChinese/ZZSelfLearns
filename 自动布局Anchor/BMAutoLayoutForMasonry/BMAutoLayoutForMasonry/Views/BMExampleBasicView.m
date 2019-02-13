//
//  BMExampleBasicView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/11.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleBasicView.h"
#import "UIView+BMLayout.h"

@implementation BMExampleBasicView

- (instancetype)init {
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
    int padding = 10;
    
    [greenView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top greaterEqual:superview.topAnchor constant:padding];
        [layout.left equal:superview constant:padding];
        [layout.bottom equal:blueView.topAnchor constant:-padding];
        [layout.right equal:redView.leftAnchor constant:-padding];
        [layout.width equal:redView];
        [layout.height equal:@[redView, blueView]];
    }];

    [redView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top equal:superview constant:padding];
        [layout.left equal:greenView.rightAnchor constant:padding];
        [layout.bottom equal:blueView.topAnchor constant:-padding];
        [layout.right equal:superview.rightAnchor constant:-padding];
        [layout.width equal:greenView];
        [layout.height equal:@[greenView, blueView]];
    }];

    [blueView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top equal:greenView.bottomAnchor constant:padding];
        [layout.left equal:superview constant:padding];
        [layout.bottom equal:superview constant:-padding];
        [layout.right equal:superview constant:-padding];
        [layout.height equal:@[greenView, redView]];
    }];
    
    return self;
}

@end
