//
//  ViewController.m
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 liuxing8807@126.com. All rights reserved.
//  http://www.fangyuzhong.com/archives/225

#import "ViewController.h"
#import "BMCoordinatesDrawer.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)draw:(id)sender {
    NSError *error = nil;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"coordinates" ofType:@"txt"];
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    if (!string || error) {
        NSLog(@"read file error: %@", error);
    }
    else {
        BMCoordinatesDrawer *drawer = [[BMCoordinatesDrawer alloc] init];
        __weak __typeof(self) weakSelf = self;
        self.imageView.image = [drawer drawImageWithConfig:^(BMCoordinatesDrawerConfig * _Nonnull config) {
            config.width            = weakSelf.imageView.frame.size.width;
            config.height           = weakSelf.imageView.frame.size.height;
            config.coordinates      = string;
            config.startPointRadius = 5;
            config.endPointRadius   = 5;
            config.marginInsets     = UIEdgeInsetsMake(10, 10, 10, 10);
        }];
    }
}

@end
