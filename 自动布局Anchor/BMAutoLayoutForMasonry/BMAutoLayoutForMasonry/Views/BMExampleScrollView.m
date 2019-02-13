//
//  BMExampleScrollView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleScrollView.h"
#import "UIView+BMLayout.h"

@interface BMExampleScrollView ()

@property (strong, nonatomic) UIScrollView* scrollView;

@end

@implementation BMExampleScrollView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    UIScrollView *scrollView = UIScrollView.new;
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor purpleColor];
    [self addSubview:scrollView];

    [self.scrollView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.edge equal:self];
        [layout.width equal:self];
    }];
    
    [self addSubview:scrollView];
    
    [self generateContent];
    
    return self;
}

- (void)generateContent {
    UIView* contentView = UIView.new;
    [self.scrollView addSubview:contentView];

    [contentView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.edge equal:self.scrollView];
        [layout.width equal:self.scrollView];
    }];

    UIView *lastView;
    CGFloat height = 25;
    
    for (int i = 0; i < 10; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        [contentView addSubview:view];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
        [view addGestureRecognizer:singleTap];
        
        [view bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.top equal:lastView? lastView.bottomAnchor : @0];
            [layout.left equal:@(0)];
            [layout.width equal:contentView];
            [layout.height equal:@(height)];
        }];
        
        height += 25;
        lastView = view;
    }
    
    [contentView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.bottom equal:lastView];
    }];
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (void)singleTap:(UITapGestureRecognizer*)sender {
    [sender.view setAlpha:sender.view.alpha / 1.20]; // To see something happen on screen when you tap :O
    [self.scrollView scrollRectToVisible:sender.view.frame animated:YES];
};

@end
