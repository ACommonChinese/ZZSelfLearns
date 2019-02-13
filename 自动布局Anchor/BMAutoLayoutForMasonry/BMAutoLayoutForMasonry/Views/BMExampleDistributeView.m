//
//  BMExampleDistributeView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/13.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleDistributeView.h"
#import "UIView+BMLayout.h"
#import "NSArray+BMAdditions.h"

@implementation BMExampleDistributeView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;

    NSMutableArray *arr = @[].mutableCopy;
    for (int i = 0; i < 4; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        view.layer.borderColor = UIColor.blackColor.CGColor;
        view.layer.borderWidth = 2;
        view.translatesAutoresizingMaskIntoConstraints = NO;

        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = [NSString stringWithFormat:@"%d", (int)i];
        label.font = [UIFont systemFontOfSize:40];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        [view addSubview:label];

        [label bm_makeLayout:^(BMLayout * _Nonnull layout) {
            [layout.leading.trailing.top.bottom equal:@(0)];
        }];

        [self addSubview:view];
        [arr addObject:view];
    }
    
    unsigned int type = 3;
    switch (type) {
        case 0: {
            [arr bm_distributeViewsAlongAxis:BMAxisTypeHorizontal withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
            [arr bm_makeLayout:^(BMLayout * _Nonnull layout) {
                [layout.top.height equal:@[@60, @100]];
            }];

            return self;
            break;
        }
        case 1: {
            [arr bm_distributeViewsAlongAxis:BMAxisTypeVertical withFixedSpacing:20 leadSpacing:5 tailSpacing:5];
            [arr bm_makeLayout:^(BMLayout * _Nonnull layout) {
                [layout.left.width equal:@[@10, @60]];
            }];
            break;
        }
        case 2: {
            [arr bm_makeLayout:^(BMLayout * _Nonnull layout) {
                [layout.top.height equal:@60];
            }];
            [arr bm_distributeViewsAlongAxis:BMAxisTypeHorizontal withFixedItemLength:30 leadSpacing:30 tailSpacing:30];
            break;
        }
        case 3: {
            [arr bm_distributeViewsAlongAxis:BMAxisTypeVertical withFixedItemLength:30 leadSpacing:30 tailSpacing:30];
            [arr bm_makeLayout:^(BMLayout * _Nonnull layout) {
                [layout.left.width equal:@[@10, @60]];
            }];
            break;
        }
            
        default:
            break;
    }
    
    return self;
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}


@end
