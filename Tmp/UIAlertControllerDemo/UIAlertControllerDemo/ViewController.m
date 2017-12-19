//
//  ViewController.m
//  UIAlertControllerDemo
//
//  Created by banma-623 on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "BMAlertController.h"
#import "BMCommonAlertContentView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)buttonClick:(id)sender {
    BMCommonAlertContentView *contentView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMCommonAlertContentView.class) owner:nil options:nil].firstObject;
    contentView.textView.text = @"BMCommonAlertContentView *contentView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMCommonAlertContentView.class) owner:nil options:nil].firstObject;BMCommonAlertContentView *contentView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMCommonAlertContentView.class) owner:nil options:nil].firstObject;BMCommonAlertContentView *contentView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(BMCommonAlertContentView.class) owner:nil options:nil].firstObject;";
    contentView.backgroundColor = [UIColor purpleColor];
    BMAlertController *controller = [BMAlertController alertControllerWithContentView:contentView];
    [controller show];
    __weak __typeof(controller) weakController = controller;
    [contentView setCallbackHandler:^{
        [weakController dismiss];
    }];
    
    
//    BMAlertControllerConfig *config = [[BMAlertControllerConfig alloc] init];
//    config.titleLabel.text = @"Hello title";
//    config.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
//    config.titleLabel.textAlignment = NSTextAlignmentCenter;
//    config.titleLabel.backgroundColor = [UIColor greenColor];
//    config.messageTextView.text = @"Hello message";
//    BMAlertController *controller = [BMAlertController alertControllerWithConfig:config];
//    [controller show];
    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action_1 = [UIAlertAction actionWithTitle:@"Hei" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:action_1];
//    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
