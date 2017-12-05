//
//  ViewController.m
//  生产者_消费者
//
//  Created by liuweizhen on 2017/12/4.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "ViewController.h"
#import "ACount.h"

@interface ViewController ()

/// 生产者消费者共用缓冲区-数组
@property (nonatomic, strong) NSMutableArray *array;
/// 信号量
@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@property (nonatomic) ACount *acount;
@end

@implementation ViewController

/// 信号量
- (IBAction)signal:(id)sender {
    [self producerFunc]; // 生产者
    [self consumerFunc]; // 消费者
}

// 生产者
- (void)producerFunc {
    __block int count = 0;
    
    // 生产者生成数据
    dispatch_queue_t t = dispatch_queue_create("222222", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t, ^{
        while (YES) {
            if (self.array.count >= 5) {
                continue; // add this if by liu wei zhen
            }
            sleep(0.5); // add by liu wei zhen
            count++;
            int t = random()%10;
            dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
            [self.array addObject:[NSString stringWithFormat:@"%zd",t]];
            dispatch_semaphore_signal(self.semaphore);
            NSLog(@"生产了%zd",count);
        }
    });
}


//消费者
- (void)consumerFunc{
    __block int count = 0;
    
    // 消费者消费数据
    dispatch_queue_t t1 = dispatch_queue_create("11111", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(t1, ^{
        while (YES) {
            sleep(2); // add later
            if (self.array.count > 0) {
                count++;
                dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
                [self.array removeLastObject];
                dispatch_semaphore_signal(self.semaphore);
                NSLog(@"消费了%zd",count);
            }
        }
    });
}

/// 懒加载共享缓冲区
- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return  _array;
}

/// 懒加载信号量
- (dispatch_semaphore_t)semaphore{
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(1);
    }
    return _semaphore;
}

/// NSCondition条件
- (IBAction)condition:(id)sender {
    self.acount = [[ACount alloc] initWithAccount:@"大刘" balanca:2000];
    NSThread *drawThread = [[NSThread alloc] initWithTarget:self selector:@selector(draw:) object:@(500)];
    NSThread *depositThread = [[NSThread alloc] initWithTarget:self selector:@selector(deposit:) object:@(100)];
    [drawThread start];
    [depositThread start];
}

- (void)draw:(NSNumber *)amount {
    [NSThread currentThread].name = @"取线程 ==> ";
    for (int i = 0; i < 500; i++) {
        sleep(3);
        [self.acount draw:amount.integerValue];
    }
}

- (void)deposit:(NSNumber *)amount {
    [NSThread currentThread].name = @"存线程 ==> ";
    for (int i = 0; i < 500; i++) {
        sleep(3);
        [self.acount deposit:amount.integerValue];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
