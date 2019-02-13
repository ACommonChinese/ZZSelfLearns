//
//  BMExampleAspectFitView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleAspectFitView.h"
#import "UIView+BMLayout.h"

@interface BMExampleAspectFitView ()

@property UIView *topView;
@property UIView *topInnerView;
@property UIView *bottomView;
@property UIView *bottomInnerView;

@end

@implementation BMExampleAspectFitView

// Designated initializer
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        // Create views
        self.topView = [[UIView alloc] initWithFrame:CGRectZero];
        self.topInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomView = [[UIView alloc] initWithFrame:CGRectZero];
        self.bottomInnerView = [[UIView alloc] initWithFrame:CGRectZero];
        
        // Set background colors
        UIColor *blueColor = [UIColor colorWithRed:0.663 green:0.796 blue:0.996 alpha:1];
        [self.topView setBackgroundColor:blueColor];
        
        UIColor *lightGreenColor = [UIColor colorWithRed:0.784 green:0.992 blue:0.851 alpha:1];
        [self.topInnerView setBackgroundColor:lightGreenColor];
        
        UIColor *pinkColor = [UIColor colorWithRed:0.992 green:0.804 blue:0.941 alpha:1];
        [self.bottomView setBackgroundColor:pinkColor];
        
        UIColor *darkGreenColor = [UIColor colorWithRed:0.443 green:0.780 blue:0.337 alpha:1];
        [self.bottomInnerView setBackgroundColor:darkGreenColor];
        
        // Layout top and bottom views to each take up half of the window
        [self addSubview:self.topView];
        
        [self.topView bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.left.right.top equal:self];
        }];
        
        [self addSubview:self.bottomView];
        [self.bottomView bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.left.right.bottom equal:self];
            [layout.top equal:self.topView.bottomAnchor];
            [layout.height equal:self.topView];
        }];

        // Inner views are configured for aspect fit with ratio of 3:1
        [self.topView addSubview:self.topInnerView];
        
        [self.topInnerView bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.width equal:self.topInnerView.heightAnchor multiplier:3]; // 宽是高的3倍
            [layout.width.height lessEqual:self.topView];
            [layout.width.height equal:self.topView].priorityLow();
            [layout.center equal:self.topView];
        }];

        [self.bottomView addSubview:self.bottomInnerView];
        [self.bottomInnerView bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.height equal:self.bottomInnerView.widthAnchor multiplier:3];
            [layout.width.height lessEqual:self.bottomView];
            [layout.width.height equal:self.bottomView].priorityLow();
            [layout.center equal:self.bottomView];
        }];
    }
    
    return self;
}


@end
