//
//  ViewController.m
//  BMSimpleLinearDemo
//
//  Created by liuweizhen on 2018/11/28.
//  Copyright © 2018 DaLiu. All rights reserved.
//

#import "ViewController.h"
#import "UIView+BMSimpleLinear.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIView *greenView;
@property (nonatomic, strong) UIView *blueView;

@property (nonatomic, strong) UIView *redViewChild1;
@property (nonatomic, strong) UIView *redViewChild2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect redRect;
    CGRect greenRect;
    CGRect blueRect;
    CGRect redChildRect1;
    CGRect redChildRect2;
    
    CGRect rect = CGRectInset(self.view.bounds, 10, 10);
    CGRectDivide(rect, &redRect, &greenRect, rect.size.height/2.0, CGRectMinYEdge);
    CGRectDivide(greenRect, &greenRect, &blueRect, greenRect.size.height/2.0, CGRectMinYEdge);
    CGRect redViewBounds = CGRectMake(0, 0, redRect.size.width, redRect.size.height);
    CGRectDivide(redViewBounds, &redChildRect1, &redChildRect2, redViewBounds.size.height/2.0, CGRectMinYEdge);
    
    self.redView = [[UIView alloc] initWithFrame:redRect];
    self.redView.backgroundColor = [UIColor redColor];
    self.greenView = [[UIView alloc] initWithFrame:greenRect];
    self.greenView.backgroundColor = [UIColor greenColor];
    self.blueView = [[UIView alloc] initWithFrame:blueRect];
    self.blueView.backgroundColor = [UIColor blueColor];
    self.redViewChild1 = [[UIView alloc] initWithFrame:redChildRect1];
    self.redViewChild1.backgroundColor = [UIColor blackColor];
    self.redViewChild2 = [[UIView alloc] initWithFrame:redChildRect2];
    self.redViewChild2.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:self.redView];
    [self.view addSubview:self.greenView];
    [self.view addSubview:self.blueView];
    [self.redView addSubview:self.redViewChild1];
    [self.redView addSubview:self.redViewChild2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button.showsTouchWhenHighlighted = YES;
    button.center = CGPointMake(CGRectGetMidX(self.view.bounds), CGRectGetHeight(self.view.bounds)-80);
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    // Make link
    [_greenView bm_vSetPrevious:_redView];
    [_blueView bm_vSetPrevious:_greenView];
    [_redViewChild1 bm_vSetPreviousSuper:_redView];
    [_redViewChild2 bm_vSetPrevious:_redViewChild1];
}

- (void)buttonClick:(UIButton *)button {
    button.selected = !button.isSelected;
    if (button.isSelected) {
        [_redView bm_vHidden:_redViewChild2];
    }
    else {
        [_redView bm_vShow:_redViewChild2];
    }
}

@end
