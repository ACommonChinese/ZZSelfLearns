//
//  ViewController.m
//  YYWeakProxyDemo
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "YYWeakProxy.h"

@interface ViewController () {
    NSTimer *_timer;
}
@end

@implementation ViewController

- (IBAction)testWeakProxy:(id)sender {
    [self initTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)initTimer {
    YYWeakProxy *proxy = [YYWeakProxy proxyWithTarget:self];
    _timer = [NSTimer timerWithTimeInterval:1 target:proxy selector:@selector(tick:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    
    // [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval) repeats:(BOOL) block:<#^(NSTimer * _Nonnull timer)block#>];
    // [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval) target:(nonnull id) selector:(nonnull SEL) userInfo:(nullable id) repeats:(BOOL)];
    // _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
    // [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    // [_timer setFireDate:[NSDate date]];
}

- (void)tick:(NSTimer *)timer {
    NSLog(@"go...");
}

@end
