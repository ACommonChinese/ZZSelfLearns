//
//  BMExampleRemakeView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/11.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleRemakeView.h"
#import "UIView+BMLayout.h"

@interface BMExampleRemakeView ()

@property (nonatomic, strong) UIButton *movingButton;
@property (nonatomic, assign) BOOL topLeft;

- (void)toggleButtonPosition;

@end

@implementation BMExampleRemakeView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.movingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.movingButton setTitle:@"Move Me!" forState:UIControlStateNormal];
    self.movingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.movingButton.layer.borderWidth = 3;
    
    [self.movingButton addTarget:self action:@selector(toggleButtonPosition) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.movingButton];
    
    self.topLeft = YES;
    
    return self;
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

// this is Apple's recommended place for adding/updating constraints
- (void)updateConstraints {
    [self.movingButton bm_resetLayout:^(BMLayout * _Nonnull layout) {
        [layout.size equal:@[@(100), @(100)]];
        if (self.topLeft) {
            [layout.left equal:self.safeAreaLayoutGuide.leftAnchor constant:10];
            [layout.top equal:self constant:10];
        }
        else {
            [layout.bottom equal:self.safeAreaLayoutGuide.bottomAnchor constant:-10];
            [layout.right equal:self constant:-10];
        }
    }];

    //according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)toggleButtonPosition {
    self.topLeft = !self.topLeft;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];
}

@end
