//
//  BMAlertController.m
//  UIAlertControllerDemo
//
//  Created by banma-623 on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "BMAlertController.h"
#import <Masonry.h>

@interface BMAlertController ()

/// 显示的内容视图
@property (nonatomic, strong) UIView *contentView;

/// 辅助呈现的window: 用于呈现rootViewController -> BMAlertController
@property(nonatomic, strong) UIWindow *previewWindow;
/// 考虑屏蔽掉多次调用show方法
@property(nonatomic, getter=isShowing) BOOL showing;

@end

@implementation BMAlertController

#pragma mark - Life cycle

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [self didInitialized];
    }
    return self;
}

- (void)didInitialized {
    [self setHidesBottomBarWhenPushed:YES];
    self.extendedLayoutIncludesOpaqueBars = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    if (!self.previewWindow) return;

    [self.view addSubview:self.contentView];
    self.contentView.transform = CGAffineTransformMakeScale(0.0, 0.0);
    __weak __typeof(self) weakSelf = self;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@300);
        make.center.equalTo(weakSelf.view);
    }];
//    [UIView animateWithDuration:0.25 animations:^{
//        weakSelf.contentView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(alertControllerDidShow:)]) {
//            [weakSelf.delegate alertControllerDidShow:weakSelf];
//        }
//    }];
    
    [UIView animateWithDuration:0.7 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionNone animations:^{
        weakSelf.contentView.transform = CGAffineTransformIdentity;
        self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    } completion:^(BOOL finished) {
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(alertControllerDidShow:)]) {
            [weakSelf.delegate alertControllerDidShow:weakSelf];
        }
    }];
}

/// 构造器 - 使用BMAlertControllerConfig对象
+ (BMAlertController *)alertControllerWithContentView:(UIView *)contentView {
    if (!contentView) return nil;
    BMAlertController *controller = [[BMAlertController alloc] init];
    controller.contentView = contentView;
    return controller;
}

/// 显示
- (void)show {
    // Let the content view show with window
    [self initPreviewWindowIfNeeded];
    self.previewWindow.rootViewController = self;
    self.previewWindow.hidden = NO;
}

/// 消失
- (void)dismiss {
    // [self previewcontroller];
    if (self.delegate && [self.delegate respondsToSelector:@selector(alertControllerWillDismiss:)]) {
        [self.delegate alertControllerWillDismiss:self];
    }
    self.showing = NO;
    [UIView animateWithDuration:.2 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.view.alpha = 0;
        // self.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.8];
    } completion:^(BOOL finished) {
        [self.contentView removeFromSuperview];
        self.previewWindow.hidden = YES;
        self.showing = NO;
        self.previewWindow.rootViewController = nil;
        self.previewWindow = nil;
    }];
}

- (void)initPreviewWindowIfNeeded {
    if (!self.previewWindow) {
        self.previewWindow = [[UIWindow alloc] init];
        self.previewWindow.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.previewWindow.backgroundColor = [UIColor clearColor];
    }
}

- (void)dealloc {
    NSLog(@"Did dealloc!");
}

@end
