//
//  SecondController.m
//  GPUImageDemo
//
//  Created by liuweizhen on 2017/11/25.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "SecondController.h"
#import "ZZScreenShot.h"
#import "ZZBlur.h"

@interface SecondController ()

@property (weak, nonatomic) IBOutlet UIImageView *originImageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SecondController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 截图
- (IBAction)buttonClick:(id)sender {
    UIImage *image = [self captureScreenForView:self.view];
    // OK: UIImage *image = [ZZScreenShot getScreenShotForView:self.originImageView];
    self.imageView.backgroundColor = [UIColor blueColor];
    self.imageView.image = image;
}

- (UIImage *)captureScreenForView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

// 截图 & 模糊
- (IBAction)shotAndBlur:(id)sender {
    UIImage *image = [ZZScreenShot getScreenShotForView:self.originImageView];
    self.imageView.image = image;
    UIVisualEffectView *blurView = [ZZBlur getBlurViewWithFrame:self.imageView.bounds];
    [self.imageView addSubview:blurView];
    
    // 以上两句代码也替换下下面这一句:
    // [ZZBlur makeBlur:self.imageView];
}

- (IBAction)dismissSelf:(id)sender {
    // Noted: 实际编码中不建议dismiss方法写在原控制器中, 可以使用代理或其他方式处理
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
