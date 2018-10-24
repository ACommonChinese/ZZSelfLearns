//
//  ViewController.m
//  DrawCoordinate
//
//  Created by liuweizhen on 2018/10/23.
//  Copyright © 2018年 banma. All rights reserved.
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
    NSLog(@"filePath: %@", filePath);
    NSString *string = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSASCIIStringEncoding error:&error];
    NSLog(@"stirng: %@", string);
    if (!string || error) {
        NSLog(@"error: %@", error);
    }
    else {
        BMCoordinatesDrawer *drawer = [[BMCoordinatesDrawer alloc] init];
        __weak __typeof(self) weakSelf = self;
        self.imageView.image = [drawer drawImageWithConfig:^(BMCoordinatesDrawerConfig * _Nonnull config) {
            config.width = weakSelf.imageView.frame.size.width;
            config.height = weakSelf.imageView.frame.size.height;
            config.coordinates = string;
        }];
    }
}

@end
