//
//  ViewController.m
//  TestRedirect
//
//  Created by 刘威振 on 16/10/8.
//  Copyright © 2016年 刘威振. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSURLSessionDelegate>

@property (nonatomic) NSMutableData *webData;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)test:(id)sender {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    NSString *url = @"http://localhost:8080/WebDemo_2/doRedirect103.jsp";
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    NSURLSessionTask *task = [session dataTaskWithRequest:request];
    [task resume];
}

- (NSMutableData *)webData {
    if (_webData == nil) {
        _webData = [[NSMutableData alloc] init];
    }
    return _webData;
}

#pragma mark - <NSURLSessionDelegate>
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"系统原因或被显式置为invalidate，error: %@", error);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"方法名：%@ === 主线程：%d === total bytes length: %lld", NSStringFromSelector(_cmd), [NSThread isMainThread], response.expectedContentLength);
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"Did become download task");
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"方法名：%@ === 主线程：%d === data length: %ld", NSStringFromSelector(_cmd), [NSThread isMainThread], data.length);
    [self.webData appendData:data];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"Did finish download to url: %@", location);
    NSString *text = [[NSString alloc] initWithData:self.webData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", text);
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"%d", [NSThread isMainThread]); // 1
    });
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"end");
    NSString *text = [[NSString alloc] initWithData:self.webData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", text);
}

// 如果这个方法不写，则默认自动重定向
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler {
    NSLog(@"重定向");
    // response.allHeaderFields
    NSLog(@"%@", response.allHeaderFields);
    /**
     {
     "Content-Length" = 0;
     "Content-Type" = "text/html;charset=UTF-8";
     Date = "Sat, 08 Oct 2016 09:22:34 GMT";
     Location = "redirect-result103.jsp";
     "Set-Cookie" = "JSESSIONID=EFBFFCC73B190622CC78F4A0ACB1A678;path=/WebDemo_2;HttpOnly";
     }
     */
    // completionHandler(nil); // 使用nil取消重定向
    // @"http://localhost:8080/WebDemo_2/doRedirect103.jsp";
    
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:8080/WebDemo_2/%@", response.allHeaderFields[@"Location"]]]];
    completionHandler(request2);
}

@end
