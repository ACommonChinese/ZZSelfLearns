//
//  BMExampleAnimatedView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleAnimatedView.h"
#import "UIView+BMLayout.h"

@interface BMExampleAnimatedView ()

@property (nonatomic, strong) NSMutableArray *animatableConstraints;
@property (nonatomic, assign) int padding;
@property (nonatomic, assign) BOOL animating;

@end


@implementation BMExampleAnimatedView


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
    int padding = self.padding = 10;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(self.padding, self.padding, self.padding, self.padding);
    
    self.animatableConstraints = NSMutableArray.new;
    
    [greenView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [self.animatableConstraints addObjectsFromArray:@[[layout.edge equal:superview inset:paddingInsets].priorityLow(),
                                                          [layout.bottom equal:blueView.topAnchor constant:-padding]]];
        [layout.size equal:redView];
        [layout.height equal:blueView.heightAnchor];
    }];

    [redView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [self.animatableConstraints addObjectsFromArray:@[[layout.edge equal:superview].insets(paddingInsets).priorityLow(),
                                                          [layout.left equal:greenView.rightAnchor constant:padding],
                                                          [layout.bottom equal:blueView.topAnchor constant:-padding]]];
        [layout.size equal:greenView];
        [layout.height equal:blueView.heightAnchor];
    }];

    [blueView bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [self.animatableConstraints addObjectsFromArray:@[[layout.edge equal:superview].insets(paddingInsets).priorityLow()]];
        [layout.height equal:@[redView, greenView]];
    }];
    
    return self;
}

- (void)didMoveToWindow {
    [self layoutIfNeeded];
    
    if (self.window) {
        self.animating = YES;
        [self animateWithInvertedInsets:NO];
    }
}

- (void)willMoveToWindow:(UIWindow *)newWindow {
    self.animating = newWindow != nil;
}

- (void)animateWithInvertedInsets:(BOOL)invertedInsets {
    if (!self.animating) return;
    
    int padding = invertedInsets ? 100 : self.padding;
    UIEdgeInsets paddingInsets = UIEdgeInsetsMake(padding, padding, padding, padding);
    for (BMLayoutConstraint *constraint in self.animatableConstraints) {
        constraint.insets = paddingInsets;
    }
    
    [UIView animateWithDuration:1 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        //repeat!
        [self animateWithInvertedInsets:!invertedInsets];
    }];
}

@end
