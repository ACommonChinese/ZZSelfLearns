//
//  BackgroundTransferServiceController.m
//  Demo
//
//  Created by 刘威振 on 4/18/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//
#import "BackgroundTransferServiceController.h"
#import "AppDelegate.h"

static NSString * const kBackgroundSessionID = @"cn.edu.scnu.DownloadTask.BackgroundSession";

@interface BackgroundTransferServiceController () <NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSURLSessionDownloadTask *backgroundDownloadTask; // 后台的下载任务
@end

@implementation BackgroundTransferServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 下载
- (IBAction)downloadData:(UIButton *)button {
    [self.backgroundDownloadTask resume];
}

// 暂停
- (IBAction)pause:(UIButton *)button {
    return;
    /**
    [self.backgroundDownloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        // 把resumeData存入沙盒缓存起来
    }];
     */
}

// 停止
- (IBAction)stop:(UIButton *)button {
    if (_backgroundDownloadTask) {
        [_backgroundDownloadTask cancel], _backgroundDownloadTask = nil;
    }
    [self setDownloadProgress:0.0];
}

// 创建一个后台session单例
- (NSURLSession *)backgroundSession {
    static NSURLSession *backgroundSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:kBackgroundSessionID];
        backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        backgroundSession.sessionDescription = kBackgroundSessionID;
    });
    return backgroundSession;
}

- (NSURLSessionDownloadTask *)backgroundDownloadTask {
    if (_backgroundDownloadTask == nil) {
        NSString *imageURLStr = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg"; // @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";
        NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        _backgroundDownloadTask = [self.backgroundSession downloadTaskWithRequest:request];
    }
    return _backgroundDownloadTask;
}

#pragma mark - <NSURLSessionDownloadDelegate>
/**
 *  执行下载任务时有数据写
 *
 *  @param session                   会话
 *  @param downloadTask              task
 *  @param bytesWritten              每次写入的data字节数
 *  @param totalBytesWritten         当前一共写入的data字节数
 *  @param totalBytesExpectedToWrite 期望收到的所有data字节数
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 计算当前下载进度并更新视图
    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    [self setDownloadProgress:downloadProgress];
}

/**
 *  从fileOffset处恢复下载任务（断点续传时）
 *
 *  @param session            会话
 *  @param downloadTask       task
 *  @param fileOffset         偏移量
 *  @param expectedTotalBytes 期望收到的所有data字节数
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    NSLog(@"Resume download at: %lld", fileOffset);
}

/**
 *  下载成功
 *
 *  @param session      会话
 *  @param downloadTask task
 *  @param location     磁盘缓存的位置（比如tmp）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSLog(@"URL: %@", downloadTask.currentRequest.URL.absoluteString);
    NSLog(@"下载完成：%@", location);
    
    // 把下载完成后的文件移到目标路径并刷新视图
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentURL         = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSURL *destinationURL      = [documentURL URLByAppendingPathComponent:location.lastPathComponent]; // 这个地方可以稍微改一下，比如以下载图片链接的md5值作为文件名
    NSLog(@"移动到：%@", destinationURL.path);
    if ([fileManager fileExistsAtPath:destinationURL.path isDirectory:NULL]) {
        [fileManager removeItemAtURL:destinationURL error:nil];
    }
    NSError *error = nil;
    if ([fileManager moveItemAtURL:location toURL:destinationURL error:&error]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setDownloadProgress:1.0];
        });
    }
    
    // 测试下面代码，最好用真机，因为我用模拟器测试，下面代码没有执行，用真机后得到执行
    self.backgroundDownloadTask = nil;
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundSessionHandler) {
        // 执行回调代码
        void (^handler)() = appDelegate.backgroundSessionHandler;
        appDelegate.backgroundSessionHandler = nil;
        handler();
    }
}

#pragma mark - 刷新视图

/* 根据下载进度更新视图 */
- (void)setDownloadProgress:(double)progress {
    NSString *progressStr = [NSString stringWithFormat:@"%.2f%%", progress*100];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = progressStr;
        self.progressView.progress = progress;
        if (progress == 0.0) {
            self.imageView.image = nil;
        }
        if (progress == 1.0) {
            self.imageView.image = [UIImage imageNamed:@"placeholder"];
        }
    });
}

@end
