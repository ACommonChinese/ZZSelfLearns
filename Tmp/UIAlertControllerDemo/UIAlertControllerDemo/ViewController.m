//
//  ViewController.m
//  UIAlertControllerDemo
//
//  Created by banma-623 on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "BMAlertController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)buttonClick:(id)sender {
    BMAlertControllerConfig *config = [[BMAlertControllerConfig alloc] init];
    config.titleLabel.text = @"Hello title";
    config.titleLabel.font = [UIFont boldSystemFontOfSize:20.0f];
    config.titleLabel.textAlignment = NSTextAlignmentCenter;
    config.titleLabel.backgroundColor = [UIColor greenColor];
    config.messageTextView.text = @"Hello message";
    BMAlertController *controller = [BMAlertController alertControllerWithConfig:config];
    [controller show];
    
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
