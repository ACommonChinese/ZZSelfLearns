//
//  ViewController.m
//  Demo
//
//  Created by 刘威振 on 4/15/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "SimpleGetController.h"
#import "SimpleGetDelegateController.h"
#import "ResumeDownloadController.h"
#import "BackgroundTransferServiceController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSMutableArray *dataArray;
@property (nonatomic) NSMutableData *webData;
@property (nonatomic, copy) dispatch_block_t completionHandler;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.dataArray = [NSMutableArray arrayWithObjects:@"Simple get with block", @"Simple get with delegate", @"Resume download (断点续传)", @"Background Fetch (后台获取) 参见本控制器代码", @"Background Transfer Service", nil];
}

- (NSMutableData *)webData {
    if (_webData == nil) {
        _webData = [[NSMutableData alloc] init];
    }
    return _webData;
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: // GET
            [self pushController:[SimpleGetController class]];
            break;
        case 1: // Session Delegate
            [self pushController:[SimpleGetDelegateController class]];
            break;
        case 2: // 断点续传
            [self pushController:[ResumeDownloadController class]];
            break;
        case 3: // 后台获取 Background-Fetch
            NSLog(@"参见代码：AppDelegate.m && ViewController.m");
            break;
        case 4: // 后台传输 Background Transfer Service
            [self pushController:[BackgroundTransferServiceController class]];
            break;
        default:
            break;
    }
}

- (void)pushController:(Class)cls {
    UIViewController *controller = [[cls alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (void)backgroundFetchWithCompletion:(dispatch_block_t)completionHandler {
    self.completionHandler = completionHandler;
    NSString *urlStr = @"http://pic27.nipic.com/20130223/890845_102043382000_2.jpg";
    NSURL *url = [NSURL URLWithString:urlStr];
    // NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:(nonnull NSString *)];
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error");
        } else {
            if (self.completionHandler) {
                NSLog(@"数据下载完成，共下载字节数：%lu", data.length);
                self.completionHandler();
            }
        }
    }] resume];
}

@end
