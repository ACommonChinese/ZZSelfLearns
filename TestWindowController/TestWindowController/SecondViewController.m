//
//  SecondViewController.m
//  TestWindowController
//
//  Created by liuweizhen on 2018/11/12.
//  Copyright © 2018 liuxing8807@126.com. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "SecondView.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.center = self.view.center;
    [button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick {
    [self dismissViewControllerAnimated:YES completion:^{
        // [((AppDelegate *)[[UIApplication sharedApplication] delegate]) resetRoot];
    }];
    // dismiss动画未执行完毕直接setRoot, 导致内存泄露
    // SecondViewController被释放，SecondView被释放
    // 但是secondView并未从视图层次结构中移除，通过查看视图层次结构可知
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) resetRoot];
}

- (void)loadView {
    SecondView *view = [[SecondView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor greenColor];
    self.view = view;
}

- (void)dealloc {
    NSLog(@"SecondViewController dealloc");
}

@end
