//
//  ViewController.m
//  GPUImageDemo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ZZiOSVersion.h"
#import "UIImage+ImageEffect.h"
#import "SecondController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)blurButtonClick:(UIButton *)sender {
    if (ZZiOSVersion.versionAvailable(__IPHONE_8_0)) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        // 毛玻璃视图
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        // 添加到要有毛玻璃特效的控件中
        effectView.frame = self.imageView.bounds;
        [self.imageView addSubview:effectView];
    } else {
        // http://www.jianshu.com/p/a5ce501fa610
        UIImage *image = [UIImage imageNamed:@"tiger.jpg"];
        self.imageView.image = [image applyLightEffect];
    }
}

- (IBAction)presentClick:(id)sender {
    SecondController *controller = [[SecondController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
}

@end
