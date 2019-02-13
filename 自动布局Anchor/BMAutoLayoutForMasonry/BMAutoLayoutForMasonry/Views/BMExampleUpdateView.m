//
//  BMExampleUpdateView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/11.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleUpdateView.h"
#import "UIView+BMLayout.h"

@interface BMExampleUpdateView ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGSize buttonSize;

@end

@implementation BMExampleUpdateView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    
    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.growingButton];
    
    self.buttonSize = CGSizeMake(100, 100);
    
    return self;
}

// A Boolean value that indicates whether the receiver depends on the constraint-based layout system.
+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    [self.growingButton bm_updateLayout:^(BMLayout * _Nonnull layout) {
        [layout.center equal:self];
        [layout.width equal:@(self.buttonSize.width)].priorityHigh();
        [layout.height equal:@(self.buttonSize.height)].priorityHigh();
        [layout.width lessEqual:self].priorityRequired();
        [layout.height lessEqual:self].priorityRequired();
    }];
    
    [super updateConstraints];
}

- (void)didTapGrowButton:(UIButton *)button {
    self.buttonSize = CGSizeMake(self.buttonSize.width * 1.3, self.buttonSize.height * 1.3);
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
