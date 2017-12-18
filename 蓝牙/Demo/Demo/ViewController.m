//
//  ViewController.m
//  Demo
//
//  Created by liuweizhen on 2017/12/7.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "BeCentralController.h"
#import "BePeripheralController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)beCentral:(id)sender {
    BeCentralController *vc = [[BeCentralController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)bePeripheral:(id)sender {
    BePeripheralController *vc = [[BePeripheralController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
