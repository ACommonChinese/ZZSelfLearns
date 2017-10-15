//
//  ViewController.m
//  ZZAttributeStrDemo
//
//  Created by liuweizhen on 2017/10/15.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ZZAttributeStrGenerator.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZZAttributeStrItem *item = [ZZAttributeStrItem itemWithStr:@"Hello world - Hello China - Hello HeNan - Hello ShangQiu - Hello YuChengXin - Hello DaHou Xiang - Hello Liu Wei Zhen" attributes:ZZAttributeStrItem.testStyle];
    self.label.numberOfLines = 0;
    self.label.attributedText = [ZZAttributeStrGenerator generateAttributedString:@[item]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
