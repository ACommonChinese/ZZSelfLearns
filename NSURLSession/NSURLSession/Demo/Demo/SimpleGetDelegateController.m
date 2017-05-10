//
//  SimpleGetDelegateController.m
//  Demo
//
//  Created by 刘威振 on 4/15/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "SimpleGetDelegateController.h"

@interface SimpleGetDelegateController () <NSURLSessionDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic) NSMutableData *webData;
@end

@implementation SimpleGetDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.backgroundColor = [UIColor redColor];
}

- (NSMutableData *)webData {
    if (_webData == nil) {
        _webData = [[NSMutableData alloc] init];
    }
    return _webData;
}

- (IBAction)downloadData:(id)sender {
    // 创建配置信息
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    // configuration.allowsCellularAccess = YES; // 是否允许蜂窝连接，常见的蜂窝网络(移动网络)类型有：GSM网络（有些国家叫pcs-1900）、CDMA网络、3G网络、FDMA、TDMA、PDC、TACS、AMPS等。从用户角度看，可以使用的接入技术包括：蜂窝移动无线系统，如3G；无绳系统，如DECT；近距离通信系统，如蓝牙和DECT数据系统；无线局域网(WLAN)系统；固定无线接入或无线本地环系统；卫星系统；广播系统，如DAB和DVB-T；ADSL和CableModem。
    // configuration.discretionary = YES; // 当程序在后台运作时由系统自己选择最佳的网络连接配置，该属性可以节省通过蜂窝连接的带宽
    // [configuration setHTTPAdditionalHeaders:@{@"Accept" : @"application/json"}]; // 只接收json数据
    // [configuration setTimeoutIntervalForRequest:10] // 超时时间
    // [configuration setTimeoutIntervalForResource:60]
    // [configuration setHTTPMaximumConnectionsPerHost:1] // 一个主机只有一个网络连接
    
    // 创建Session
    // NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    // NSURLSession *session  = [NSURLSession sharedSession];
    // [session invalidateAndCancel]; --> 这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。Delegate收到这个事件之后会被解引用。
    // [session finishTasksAndInvalidate]; --> 这时Delegate会收到URLSession:didBecomeInvalidWithError:这个事件。Delegate收到这个事件之后会被解引用。
    /**
     From Apple:
     Note: An NSURLSession object need not have a delegate. If no delegate is assigned, when you create tasks in that session, you must provide a completion handler block to obtain the data.
     
     Completion handler block are primarily intended as an alternative to using a custom delegate. If you create a task using a method that takes a completion handler block, the delegate methods for response and data delivery are not called.
     
     NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image       = [UIImage imageWithData:data];
                self.imageView.image = image;
        });
     }];
     */
    
    // 创建Request
    NSString *urlStr        = @"http://img2.3lian.com/2014/f5/158/d/85.jpg";
    NSURLRequest *request   = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    // 创建并启动Task
    NSURLSessionTask *task  = [session dataTaskWithRequest:request]; // [session dataTaskWithURL:nil completionHandler:nil];
    [task resume];
}

#pragma mark - <NSURLSessionDelegate>
/* The last message a session receives.  A session will only become
 * invalid because of a systemic error or when it has been
 * explicitly invalidated, in which case the error parameter will be nil.
 */
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(nullable NSError *)error {
    NSLog(@"系统原因或被显式置为invalidate，error: %@", error);
}

/* If implemented, when a connection level authentication challenge
 * has occurred, this delegate will be given the opportunity to
 * provide authentication credentials to the underlying
 * connection. Some types of authentication will apply to more than
 * one request on a given connection to a server (SSL Server Trust
 * challenges).  If this delegate message is not implemented, the
 * behavior will be to use the default handling, which may involve user
 * interaction.
 */
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {}

/* If an application has received an
 * -application:handleEventsForBackgroundURLSession:completionHandler:
 * message, the session delegate will receive this message to indicate
 * that all messages previously enqueued for this session have been
 * delivered.  At this time it is safe to invoke the previously stored
 * completion handler, or to begin any internal updates that will
 * result in invoking the completion handler.
 */
- (void)URLSessionDidFinishEventsForBackgroundURLSession:(NSURLSession *)session {
    NSLog(@"Did finish background url session");
} // NS_AVAILABLE_IOS(7_0);

#pragma mark - <NSURLSessionTaskDelegate>
#pragma mark - <NSURLSessionTaskDelegate>
/* An HTTP request is attempting to perform a redirection to a different
 * URL. You must invoke the completion routine to allow the
 * redirection, allow the redirection with a modified request, or
 * pass nil to the completionHandler to cause the body of the redirection
 * response to be delivered as the payload of this request. The default
 * is to follow redirections.
 *
 * For tasks in background sessions, redirections will always be followed and this method will not be called.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * __nullable))completionHandler {}

/* The task has received a request specific authentication challenge.
 * If this delegate is not implemented, the session specific authentication challenge
 * will *NOT* be called and the behavior will be the same as using the default handling
 * disposition.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler {}

/* Sent if a task requires a new, unopened body stream.  This may be
 * necessary when authentication has failed for any request that
 * involves a body stream.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
 needNewBodyStream:(void (^)(NSInputStream * __nullable bodyStream))completionHandler {}

/* Sent periodically to notify the delegate of upload progress.  This
 * information is also available as properties of the task.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
   didSendBodyData:(int64_t)bytesSent
    totalBytesSent:(int64_t)totalBytesSent
totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {}

/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    NSLog(@"End");
}

#pragma mark - <NSURLSessionDataDelegate>
/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 *
 * This method will not be called for background upload tasks (which cannot be converted to download tasks).
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"方法名：%@ === 主线程：%d === total bytes length: %lld", NSStringFromSelector(_cmd), [NSThread isMainThread], response.expectedContentLength);
    completionHandler(NSURLSessionResponseAllow);
    /**
     typedef NS_ENUM(NSInteger, NSURLSessionResponseDisposition) {
     NSURLSessionResponseCancel = 0,                                      // Cancel the load, this is the same as -[task cancel]
     NSURLSessionResponseAllow = 1,                                       // Allow the load to continue
     NSURLSessionResponseBecomeDownload = 2,                              // Turn this request into a downloads
     NSURLSessionResponseBecomeStream NS_ENUM_AVAILABLE(10_11, 9_0) = 3,  // Turn this task into a stream task
     } NS_ENUM_AVAILABLE(NSURLSESSION_AVAILABLE, 7_0);
     */
}

/* Notification that a data task has become a download task.  No
 * future messages will be sent to the data task.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeDownloadTask:(NSURLSessionDownloadTask *)downloadTask {
    NSLog(@"Did become download task");
}

/*
 * Notification that a data task has become a bidirectional stream
 * task.  No future messages will be sent to the data task.  The newly
 * created streamTask will carry the original request and response as
 * properties.
 *
 * For requests that were pipelined, the stream object will only allow
 * reading, and the object will immediately issue a
 * -URLSession:writeClosedForStream:.  Pipelining can be disabled for
 * all requests in a session, or by the NSURLRequest
 * HTTPShouldUsePipelining property.
 *
 * The underlying connection is no longer considered part of the HTTP
 * connection cache and won't count against the total number of
 * connections per host.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didBecomeStreamTask:(NSURLSessionStreamTask *)streamTask {}

/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be discontiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"方法名：%@ === 主线程：%d === data length: %ld", NSStringFromSelector(_cmd), [NSThread isMainThread], data.length);
    [self.webData appendData:data];
    dispatch_sync(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:self.webData];
    });
    /**
     [data enumerateByteRangesUsingBlock:^(const void * bytes, NSRange byteRange, BOOL * stop) {
     NSData *newData = [NSData dataWithBytes:bytes length:byteRange.length];
     [self.webData appendData:newData];
     }];
     */
}

/* Invoke the completion routine with a valid NSCachedURLResponse to
 * allow the resulting data to be cached, or pass nil to prevent
 * caching. Note that there is no guarantee that caching will be
 * attempted for a given resource, and you should not rely on this
 * message to receive the resource data.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * __nullable cachedResponse))completionHandler {}

#pragma mark - <NSURLSessionDownloadDelegate>

/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    NSLog(@"Did finish download to url: %@", location);
    NSLog(@"%d", [NSThread isMainThread]); // 0, not the main thread
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"%d", [NSThread isMainThread]); // 1
        self.imageView.image = [UIImage imageWithData:self.webData];
    });
    
    ////////////////////////////////////////////////////////////////////////////////////
#if 0
    // We've successfully finished the download, Let's save the file
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *urls = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsDirectory = urls[0];
    NSURL *destinationPath = [documentsDirectory URLByAppendingPathComponent:[location lastPathComponent]];
    NSError *error = nil;
    
    // Make sure we overwrite anything that's already there
    [fileManager removeItemAtURL:destinationPath error:nil];
    // BOOL success = [fileManager copyItemAtPath:(nonnull NSString *) toPath:(nonnull NSString *) error:(NSError * _Nullable __autoreleasing * _Nullable)];
    BOOL success = [fileManager copyItemAtURL:location toURL:destinationPath error:&error];
    if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithContentsOfFile:[destinationPath path]];
            self.imageView.image = image;
            // ...
        });
    } else {
        NSLog(@"Couldn't copy the downloaded file");
    }
#endif
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 在这里可以追踪下载进度
#if 0
    double currentProgress = (double)totalBytesWritten / (double)totalBytesExpectedToWrite;
    NSLog(@"%f", currentProgress);
    dispatch_async(dispatch_get_main_queue(), ^{
        // self.progressView.progress = currentProgress;
    });
#endif
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes {}

@end

/**
 点击下载数据按钮后程序的打印结果：
 2016-04-15 14:52:04.818 Demo[10843:506840] 方法名：URLSession:dataTask:didReceiveResponse:completionHandler: === 主线程：0 === total bytes length: 19505
 2016-04-15 14:52:04.819 Demo[10843:506840] 方法名：URLSession:dataTask:didReceiveData: === 主线程：0 === data length: 5542
 2016-04-15 14:52:04.863 Demo[10843:506870] 方法名：URLSession:dataTask:didReceiveData: === 主线程：0 === data length: 2896
 2016-04-15 14:52:04.864 Demo[10843:506854] 方法名：URLSession:dataTask:didReceiveData: === 主线程：0 === data length: 8688
 2016-04-15 14:52:04.908 Demo[10843:506854] 方法名：URLSession:dataTask:didReceiveData: === 主线程：0 === data length: 2379
 而且图片是一点点显示，逐渐显示全的
 */
