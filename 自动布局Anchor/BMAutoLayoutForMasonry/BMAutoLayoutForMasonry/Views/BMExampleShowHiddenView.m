//
//  BMExampleShowHiddenView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/13.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleShowHiddenView.h"
#import "UIView+BMLayout.h"

@interface BMExampleShowHiddenView ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;

@end

@implementation BMExampleShowHiddenView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.redView = UIView.new;
    self.redView.backgroundColor = UIColor.redColor;
    self.greenView = UIView.new;
    self.greenView.backgroundColor = UIColor.greenColor;
    self.blueView = UIView.new;
    self.blueView.backgroundColor = UIColor.blueColor;
    [self addSubview:self.redView];
    [self addSubview:self.greenView];
    [self addSubview:self.blueView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"Show|Hidden" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left.bottom.right.height equal:@[@20, @-20, @-20, @40]];
    }];
    
    [self.redView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left.top.right equal:@[@20, @20, @-20]];
        [layout.height equal:@(100)];
    }];
    
    [self.greenView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left.right equal:@[@20, @-20]];
        [layout.top equal:self.redView.bottomAnchor];
        [layout.height equal:@(100)];
    }];
    
    [self.blueView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left.right equal:@[@20, @-20]];
        [layout.height equal:@(100)];
        [layout.top equal:self.greenView.bottomAnchor];
    }];
    
    return self;
}

- (void)buttonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.isSelected) {
        self.greenView.layout.heightConstraint.systemConstraint.constant = 0;
    }
    else {
        self.greenView.layout.heightConstraint.systemConstraint.constant = 100;
    }
}

@end
