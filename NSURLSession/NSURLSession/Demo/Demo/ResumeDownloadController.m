//
//  ResumeDownloadController.m
//  Demo
//
//  Created by 刘威振 on 4/15/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ResumeDownloadController.h"

@interface ResumeDownloadController () <NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;       // 要下载的图片呈现视图
@property (weak, nonatomic) IBOutlet UIProgressView *progressView; // 进度条视条
@property (strong, nonatomic) IBOutlet UILabel *progressLabel;      // 进度百分比显示

/** 可恢复的下载任务 */
@property (strong, nonatomic) NSURLSessionDownloadTask *downloadTask;

/** 可恢复的下载任务的数据 */
@property (strong, nonatomic) NSData *resumeData;
@end

@implementation ResumeDownloadController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (NSURLSessionDownloadTask *)downloadTask {
    if (_downloadTask == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        if (self.resumeData) {
            _downloadTask = [session downloadTaskWithResumeData:self.resumeData];
        } else {
            NSString *url = @"http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg";
            // NSString *url = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg";
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
            _downloadTask = [session downloadTaskWithRequest:request];
        }
    }
    return _downloadTask;
}

// 下载
- (IBAction)downloadData:(id)sender {
    [self.downloadTask resume];
}

// 暂停
- (IBAction)pause:(id)sender {
    // [self.downloadTask suspend];
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData; // 这个resumeData就是我们当前已下载的数据, 注意这种做法是把数据缓存到内存，如果把支持程序退出后再进来还能断点续传，则应当把这个数据写到沙盒中
        // [self setImageWithData:resumeData]; // 局部图片并不显示！
    }];
    self.downloadTask = nil;
}

/**
- (void)setImageWithData:(NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
    });
}
*/

// 取消
- (IBAction)cancel:(id)sender {
    if (self.downloadTask) {
        [self.downloadTask cancel];
        self.resumeData = nil;
    }
    self.downloadTask = nil;
    [self setDownloadProgress:0.0];
}

#pragma mark - <NSURLSessionDownloadDelegate>
/**
 *  执行下载任务时有数据写入
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
    NSLog(@"当前下载进度：%lf", downloadProgress);
    [self setDownloadProgress:downloadProgress];
}

/**
 *  下载完成
 *
 *  @param session      会话
 *  @param downloadTask task
 *  @param location     磁盘缓存的位置（比如tmp）
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSLog(@"URL: %@", downloadTask.currentRequest.URL.absoluteString);
    NSLog(@"下载完成: %@", location);
    
    // 把下载完成后的文件移到目标路径并刷新视图
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentURL = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask][0];
    NSURL *destURL = [documentURL URLByAppendingPathComponent:location.lastPathComponent]; // 这个地方可以稍微改一下，比如以下载图片链接的md5值作为文件名，略
    NSLog(@"移动到：%@", destURL);
    if ([fileManager fileExistsAtPath:destURL.path isDirectory:NULL]) {
        [fileManager removeItemAtURL:destURL error:nil];
    }
    NSError *error = nil;
    if ([fileManager moveItemAtURL:location toURL:destURL error:&error]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setDownloadProgress:1.0];
            UIImage *image = [UIImage imageWithContentsOfFile:destURL.path];
            self.imageView.image = image;
        });
    }
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

#pragma mark - 刷新视图
- (void)setDownloadProgress:(double)progress {
    NSString *str = [NSString stringWithFormat:@"%.2f%%", progress * 100];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = str;
        self.progressView.progress = progress;
    });
    if (progress == 0.0) {
        self.imageView.image = nil;
    }
}

@end
