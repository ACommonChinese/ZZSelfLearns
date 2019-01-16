//
//  ViewController.m
//  TestWindowController
//
//  Created by liuweizhen on 2018/11/12.
//  Copyright © 2018 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
}

- (IBAction)buttonClick:(id)sender {
    SecondViewController *vc = SecondViewController.new;
    [self presentViewController:vc animated:YES completion:nil];
}

//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//
//    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) resetRootController2];
//
//}

- (IBAction)setRoot:(id)sender {
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) resetRoot];
}

@end
