//
//  BMAlertController.m
//  UIAlertControllerDemo
//
//  Created by banma-623 on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "BMAlertController.h"
#import <Masonry.h>

@implementation BMAlertControllerConfig
@synthesize titleLabel = _titleLabel;
@synthesize messageTextView = _messageTextView;

- (instancetype)init {
    if (self = [super init]) {
        self.defaultWidth = 300;
        self.cornerRadius = 5;
    }
    return self;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UITextView *)messageTextView {
    if (_messageTextView == nil) {
        _messageTextView = [[UITextView alloc] init];
    }
    return _messageTextView;
}

@end

@interface BMAlertController ()

/// config配置信息对象
@property (nonatomic, strong) BMAlertControllerConfig *config;
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
    // CGRect transitionFromRect = CGRectMake(0, 0, 100, 100)
    
    
//    CGRect transitionToRect   = self.contentView.frame;
//    [UIView animateWithDuration:0.7 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:1 options:UIViewAnimationOptionTransitionNone animations:^{
//        self.contentView.frame = transitionToRect;
//    } completion:^(BOOL finished) {
//       // [self previewControllerDidShow];
//    }];
}

/// 构造器 - 使用BMAlertControllerConfig对象
+ (BMAlertController *)alertControllerWithConfig:(BMAlertControllerConfig *)config {
    if (!config) return nil;
    BMAlertController *controller = [[BMAlertController alloc] init];
    controller.config = config;
    return controller;
}

/// 构造器 - 使用customView对象
+ (BMAlertController *)alertControllerWithCustomView:(UIView *)customView {
    if (!customView) return nil;
    BMAlertController *controller = [[BMAlertController alloc] init];
    controller.contentView = customView;
    return controller;
}

/// 显示
- (void)show {
    // Prepare the content view for show
    [self loadContentView];
    
    // Let the content view show with window
    [self initPreviewWindowIfNeeded];
    self.previewWindow.rootViewController = self;
    self.previewWindow.hidden = NO;
}

- (void)loadContentView {
    if (!self.contentView) {
        self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.config.defaultWidth, 5)];
        self.contentView.backgroundColor = [UIColor redColor];
        [self.view addSubview:self.contentView];
        __weak __typeof(self) weakSelf = self;
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.width.equalTo(@(weakSelf.config.defaultWidth));
            make.center.equalTo(weakSelf.view);
        }];
        
        UILabel *titleLabel = self.config.titleLabel;
        UITextView *messageTextView = self.config.messageTextView;
        [self.contentView addSubview:titleLabel];
        [self.contentView addSubview:messageTextView];
        messageTextView.backgroundColor = [UIColor purpleColor];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.equalTo(@0);
            
        }];
    }
}

- (void)resetContentView {}

/// 消失
- (void)dismiss {
    
}

- (void)initPreviewWindowIfNeeded {
    if (!self.previewWindow) {
        self.previewWindow = [[UIWindow alloc] init];
        self.previewWindow.windowLevel = UIWindowLevelStatusBar + 1.0;
        self.previewWindow.backgroundColor = [UIColor clearColor];
    }
}


@end
