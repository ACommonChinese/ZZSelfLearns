//
//  ViewController.m
//  AvoidButtonQuickClick
//
//  Created by 刘威振 on 11/30/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "UIControl+AvoidQuickTouch.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.button.minimumEventInterval = 2; // 设置最小间隔时间，在2秒内多次点击只会响应第一次点击
}

- (IBAction)buttonClick:(id)sender {
    NSLog(@"Button clicked.");
    // NSLog(@"%lf", self.button.minimumEventInterval);
}

@end
