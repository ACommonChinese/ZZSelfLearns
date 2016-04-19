//
//  SimpleGetController.m
//  Demo
//
//  Created by 刘威振 on 4/15/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "SimpleGetController.h"

@interface SimpleGetController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation SimpleGetController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)downloadData:(id)sender {
    // 创建Session配置信息
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // 创建Session
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config];
    
    // 创建Request
    NSString *url = @"http://img2.3lian.com/2014/f5/158/d/85.jpg";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // __block NSURLSessionTask *task;
    /** It's ok
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // NSLog(@"%@", task); // null, if you want to use task, you should  add __block outside this block, just like: __block NSURLSessionTask *task; if not, the task will be nil after the end of it's method: download:
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSLog(@"数据总长度 %lld", httpResponse.expectedContentLength);
        NSLog(@"%d", [NSThread isMainThread]); // 0 不是主线程
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%d", [NSThread isMainThread]); // 1 是主线程
            self.imageView.image = image;
        });
    }];
     */
    
    // 创建task并启动
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%d", [NSThread isMainThread]); // 1 是主线程
            self.imageView.image = image;
        });
    }];
    [task resume];
    
    /**
     * [task suspend];
     
     * [task cancel], task = nil; // --> It will call the URLSession:task:didCompleteWithError:
    
     -- 恢复下载
     [task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {}]; // resumeData是已下载了的数据
     */
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}

@end
