//
//  BMExampleLabelView.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/12.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleLabelView.h"
#import "UIView+BMLayout.h"

static UIEdgeInsets const kPadding = {10, 10, 10, 10};

@interface BMExampleLabelView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *longLabel;

@end

@implementation BMExampleLabelView

- (id)init {
    self = [super init];
    if (!self) return nil;
    
    self.backgroundColor = [UIColor yellowColor];
    
    // text courtesy of http://baconipsum.com/
    
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.button setTitle:@"More text" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(moreText:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    CGFloat maxLongLabelWidth = [UIScreen mainScreen].bounds.size.width - self.button.intrinsicContentSize.width - 2*kPadding.left;
    
    self.longLabel = UILabel.new;
    self.longLabel.numberOfLines = 0;
    self.longLabel.textColor = [UIColor darkGrayColor];
    self.longLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.longLabel.preferredMaxLayoutWidth = maxLongLabelWidth; /// The preferred maximum width (in points) for a multiline label.
    self.longLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock jowl pastrami flank short loi.";
    [self addSubview:self.longLabel];
    
    [self.longLabel bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.left equal:self].insets(kPadding);
        [layout.top equal:self].insets(kPadding);
    }];

    self.longLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.longLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:10].active = YES;
    [self.longLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:10].active = YES;
    [self.longLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-(self.button.intrinsicContentSize.width + 2*kPadding.left)].active = YES;
    
    [self.button bm_makeLayout:^(BMLayout * _Nonnull layout) {
        [layout.top equal:self.longLabel.lastBaselineAnchor].priorityHigh();
        [layout.right equal:self].insets(kPadding);
        [layout.bottom lessEqual:@(-10)];
    }];

    return self;
}

- (void)moreText:(id)sender {
    static int i = 0;
    NSString *text = [NSString stringWithFormat:@"%@\n%d: %@", self.longLabel.text, ++i, @"attach more text"];
    self.longLabel.text = text;
}

@end
