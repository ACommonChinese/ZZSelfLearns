//
//  ViewController.m
//  TestJSCaller
//
//  Created by liuweizhen on 2018/12/19.
//  Copyright © 2018 banma. All rights reserved.
//

#import "ViewController.h"
#import "ZXQWebViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click:(id)sender {
    ZXQWebViewController *controller = [[ZXQWebViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
