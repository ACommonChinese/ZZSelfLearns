//
//  ViewController.m
//  Demo_1
//
//  Created by 刘威振 on 4/19/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+Student.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Student *student = [[Student alloc] init];
    student.id = @"080902053";
    student.name = @"刘威振";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoDark];
    button.center = self.view.center;
    button.student = student;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClick:(UIButton *)button {
    Student *student = button.student;
    NSLog(@"id: %@ -- name: %@", student.id, student.name); // id: 080902053 -- name: 刘威振
}

@end
