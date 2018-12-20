//
//  ZXQWebViewController.m
//  TestJSCaller
//
//  Created by liuweizhen on 2018/12/19.
//  Copyright © 2018 banma. All rights reserved.
//

#import "ZXQWebViewController.h"

@interface ZXQWebViewController ()

@property (nonatomic, weak) JSManagedValue *managedValue;

@end

@implementation ZXQWebViewController

- (void)callTel:(NSString *)params {
    NSLog(@"callTel: %@", params);
}

- (void)eat:(NSString *)food {
    NSLog(@"eat: %@", food);
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor blackColor];
    button.frame = CGRectMake(20, 300, 200, 100);
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeSystem];
    button2.backgroundColor = [UIColor blackColor];
    button2.frame = CGRectMake(20, 500, 200, 100);
    [button2 setTitle:@"Reload" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(reload:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
}

- (void)reload:(id)sender {
    [self loadJsContext];
}

- (void)buttonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"ZXQWebViewController did dealloc");
}

@end
