//
//  ViewController.m
//  NSURLSessionDownloadDemo
//
//  Created by 刘威振 on 12/28/15.
//  Copyright © 2015 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#pragma mark - Constants

static NSString * const kCurrentSession      = @"Current Session";
static NSString * const kBackgroundSession   = @"Background Session";
static NSString * const kBackgroundSessionID = @"cn.edu.scnu.DownloadTask.BackgroundSession";

@interface ViewController () <NSURLSessionDownloadDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;


/* 根据下载进度更新视图 */
@property (nonatomic) NSURLSession *currentSession;    // 当前会话
@property (nonatomic) NSURLSession *backgroundSession; // 后台会话

/* 下载任务 */
@property (nonatomic) NSURLSessionDownloadTask *commonDownloadTask;     // 一般的下载任务
@property (nonatomic) NSURLSessionDownloadTask *resumeDownloadTask;     // 可恢复的下载任务
@property (nonatomic) NSURLSessionDownloadTask *backgroundDownloadTask; // 后台的下载任务

/* UIBarbuttonItem */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *commonDownloadItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resumeDownloadItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backgroundDownloadItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelDownloadItem;


/* 用于可恢复的下载任务的数据 */
@property (strong, nonatomic) NSData *partialData; //用于可恢复的下载任务的数据

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDownloadProgress:0];
}

#pragma mark - Button Actions

// 普通下载
- (IBAction)commonDownload:(id)sender {
    [self setDownloadButtonsWithEnabled:NO];
    self.imageView.image = nil;
    [self.commonDownloadTask resume];
}

// 断点续传下载
- (IBAction)resumeDownload:(id)sender {
    [self setDownloadButtonsWithEnabled:NO];
    self.imageView.image = nil;
    [self.resumeDownloadTask resume];
}

// 后台下载
- (IBAction)backgroundDownload:(id)sender {
    [self setDownloadButtonsWithEnabled:NO];
    self.imageView.image = nil;
    
//    [self.backgroundSession getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
//        for (NSURLSessionDownloadTask *task in downloadTasks) {
//            NSLog(@"Got it!!!!!!!");
//        }
//    }];
//
    [self.backgroundDownloadTask resume];
}

// 取消下载
- (IBAction)cancelDownload:(id)sender {
    if (_commonDownloadTask) {
        [_commonDownloadTask cancel], _commonDownloadTask = nil;
    }
    if (_resumeDownloadTask) {
        [_resumeDownloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            // 这个resumeData就是我们当前已下载的数据
            self.partialData = resumeData; // 注意这种做法是把数据缓存到内存，如果把支持程序退出后再进来还能断点续传，则应当把这个数据写到沙盒中
            _resumeDownloadTask = nil;
        }];
    }
    if (_backgroundDownloadTask) {
        
        
        [_backgroundDownloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.partialData = resumeData;
            _backgroundDownloadTask = nil;
        }];
        // [_backgroundDownloadTask cancel], _backgroundDownloadTask = nil;
    }
    
    [self setDownloadProgress:0.0];
    self.imageView.image = nil;
    [self setDownloadButtonsWithEnabled:YES];
}

#pragma mark - 懒加载

// 普通下载任务
- (NSURLSessionDownloadTask *)commonDownloadTask {
    if (!_commonDownloadTask) {
        NSString *imageURLStr = @"http://farm6.staticflickr.com/5505/9824098016_0e28a047c2_b_d.jpg";
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
        _commonDownloadTask   = [self.currentSession downloadTaskWithRequest:request];
    }
    return _commonDownloadTask;
}

// 断点续传下载任务
- (NSURLSessionDownloadTask *)resumeDownloadTask {
    if (_resumeDownloadTask == nil) {
        if (self.partialData) { // 如果是之前被暂停的任务，就从已经保存的数据恢复下载
            _resumeDownloadTask = [self.currentSession downloadTaskWithResumeData:_partialData];
        } else { // 否则创建下载任务
            NSString *imageURLStr = @"http://farm3.staticflickr.com/2846/9823925914_78cd653ac9_b_d.jpg";
            // NSString *imageURLStr = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg";
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
            _resumeDownloadTask = [self.currentSession downloadTaskWithRequest:request];
        }
    }
    return _resumeDownloadTask;
}

- (NSURLSessionDownloadTask *)backgroundDownloadTask {
    if (_backgroundDownloadTask == nil) {
        // add later
        if (self.partialData) {
            _backgroundDownloadTask = [self.backgroundSession downloadTaskWithResumeData:_partialData];
        } else {
            // NSString *imageURLStr   = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg"; // @"http://farm3.staticflickr.com/2831/9823890176_82b4165653_b_d.jpg";
            NSString *imageURLStr = @"http://dlsw.baidu.com/sw-search-sp/soft/2a/25677/QQ_V4.0.0.1419920162.dmg";
            NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURLStr]];
            _backgroundDownloadTask = [self.backgroundSession downloadTaskWithRequest:request];
        }
    }
    return _backgroundDownloadTask;
}

// 对于后台任务，NSURLSessionConfiguration设置了ID，再次启动时会收到上次强退的那个任务的结果（失败），直接跳到didCompleteWithError，所以进来就会直接弹出失败
//当前的session
- (NSURLSession *)currentSession {
    if (!_currentSession) {
        NSURLSessionConfiguration *defaultConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
        _currentSession                          = [NSURLSession sessionWithConfiguration:defaultConfig delegate:self delegateQueue:nil];
        _currentSession.sessionDescription       = kCurrentSession;
    }
    return _currentSession;
}

// 创建一个后台session单例
- (NSURLSession *)backgroundSession {
    static NSURLSession *backgroundSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:kBackgroundSessionID];
        backgroundSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
        backgroundSession.sessionDescription = kBackgroundSession;
        _backgroundSession = backgroundSession;
    });
    return backgroundSession;
}

#pragma mark - 刷新视图

/* 根据下载进度更新视图 */
- (void)setDownloadProgress:(double)progress {
    NSString *progressStr = [NSString stringWithFormat:@"%.2f%%", progress*100];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.progressLabel.text = progressStr;
        self.progressView.progress = progress;
    });
}

- (void)setDownloadButtonsWithEnabled:(BOOL)enabled {
    self.commonDownloadItem.enabled = self.resumeDownloadItem.enabled = self.backgroundDownloadItem.enabled = enabled;
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
    NSLog(@"下载中...");
    double downloadProgress = totalBytesWritten / (double)totalBytesExpectedToWrite;
    [self setDownloadProgress:downloadProgress];
}

/**
 *  下载成功
 *
 *  @param session      会话
 *  @param downloadTask task
 *  @param location     磁盘缓存的位置（比如tmp）
 */
// 经测试，程序进入后台后代理方法“下载中”未得到调用，但此方法会得到调用
- (void)URLSession:(NSURLSession *)session downloadTask:(nonnull NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    NSLog(@"URL: %@", downloadTask.currentRequest.URL.absoluteString);
    NSLog(@"下载完成：%@", location);
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"t" message:@"messag" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [alertView show];
    
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
            
            if (session == _backgroundSession) {
                self.imageView.image = [UIImage imageNamed:@"placeholder"];
            } else {
                UIImage *image       = [UIImage imageWithContentsOfFile:destinationURL.path];
                self.imageView.image = image;
            }
            
            [self setDownloadButtonsWithEnabled:YES];
        });
    }
    
    // 取消已下载完的任务
    _commonDownloadTask = nil;
    _resumeDownloadTask = nil;
    _partialData        = nil;
    if (session == _backgroundSession) {
        self.backgroundDownloadTask = nil;
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        if (appDelegate.backgroundURLSessionCompletionHandler) {
            
            // 执行回调代码
            void (^handler)() = appDelegate.backgroundURLSessionCompletionHandler;
            appDelegate.backgroundURLSessionCompletionHandler = nil;
            handler();
        }
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

// 代理方法 下载完成回调 didCompleteWithError
// App在后台的时候下载还会继续，当下载完成后会和AppDelegate交互：- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)())completionHandler
// 当程序再进来，此方法会得到调用
// 该方法执行的前提条件：1-App进入后台 2-在后台把数据下载完成 3-再从后台启动APP
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    NSData *resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.backgroundURLSessionCompletionHandler) {
        void (^completionHandler)() = appDelegate.backgroundURLSessionCompletionHandler;
        appDelegate.backgroundURLSessionCompletionHandler = nil;
        completionHandler();
    }
    NSLog(@"All tasks are finished!");
    
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"App从后台被杀死进来，All task finished" message:[NSString stringWithFormat:@"App resume data length: %ld", resumeData.length] delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
//    [alertView show];
    
    // 程序被杀掉，再次开启时会调用这里
    // 取到断点data,再次开启下载任务
//    NSLog(@"后台重启");
//    NSData *resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];
//    NSLog(@"APP resumeData length: %ld", resumeData.length);
}

//[self.session getTasksWithCompletionHandler:^(NSArray<NSURLSessionDataTask *> * _Nonnull dataTasks, NSArray<NSURLSessionUploadTask *> * _Nonnull uploadTasks, NSArray<NSURLSessionDownloadTask *> * _Nonnull downloadTasks) {
//    for (NSURLSessionDownloadTask *task in downloadTasks) {
//        [self.currentDownloadTask setObject:task forKey:[NSString stringWithFormat:@"%lu",task.taskIdentifier]];
//    }
//    dispatch_async(dispatch_get_main_queue(), ^{
//        finished();
//    });
//
//}];

@end
