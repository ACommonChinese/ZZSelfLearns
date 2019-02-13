//
//  BMExampleArrayView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/13.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleArrayView.h"
#import "UIView+BMLayout.h"
#import "NSArray+BMAdditions.h"

static CGFloat const kArrayExampleIncrement = 10.0;

@interface BMExampleArrayView ()

@property (nonatomic, assign) CGFloat offset;
@property (nonatomic, strong) NSArray *buttonViews;

@end

@implementation BMExampleArrayView


- (id)init {
    self = [super init];
    if (!self) return nil;
    
    UIButton *raiseButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [raiseButton setTitle:@"Raise" forState:UIControlStateNormal];
    [raiseButton addTarget:self action:@selector(raiseAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:raiseButton];
    
    UIButton *centerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [centerButton setTitle:@"Center" forState:UIControlStateNormal];
    [centerButton addTarget:self action:@selector(centerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:centerButton];
    
    UIButton *lowerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [lowerButton setTitle:@"Lower" forState:UIControlStateNormal];
    [lowerButton addTarget:self action:@selector(lowerAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:lowerButton];
    
    raiseButton.backgroundColor = centerButton.backgroundColor = lowerButton.backgroundColor = [UIColor yellowColor];
    
    UIView *markView = UIView.new;
    markView.backgroundColor = [UIColor redColor];
    [self addSubview:markView];
    
    [markView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.width equal:self];
        [layout.height equal:@(1)];
        [layout.center equal:self];
    }];
    
    [lowerButton bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left equal:self constant:10];
    }];
    
    [centerButton bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.centerX equal:self];
    }];

    [raiseButton bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.right equal:self constant:-10];
    }];

    self.buttonViews = @[ raiseButton, lowerButton, centerButton ];
    
    return self;
}

- (void)centerAction {
    self.offset = 0.0;
}

- (void)raiseAction {
    self.offset -= kArrayExampleIncrement;
}

- (void)lowerAction {
    self.offset += kArrayExampleIncrement;
}

- (void)setOffset:(CGFloat)offset {
    _offset = offset;
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.buttonViews bm_updateLayout:^(BMLayout * _Nonnull layout) {
        [layout.lastBaseline equal:self.centerYAnchor constant:self.offset];
    }];
    
    //according to apple super should be called at end of method
    [super updateConstraints];
}

@end
