//
//  InteractViewController.m
//  WKWebViewDemo
//
//  Created by liuweizhen on 2019/3/26.
//  Copyright © 2019 daliu. All rights reserved.
//

#import "InteractViewController.h"
#import <WebKit/WebKit.h>

@interface InteractViewController () <WKScriptMessageHandler>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation InteractViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor whiteColor];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.preferences.minimumFontSize = 18.0;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.topView.bounds configuration:config];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSURL *baseURL = [[NSBundle mainBundle] bundleURL];
    [self.webView loadHTMLString:[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil] baseURL:baseURL];
    [self.topView addSubview:self.webView];
    
    WKUserContentController *userCC = config.userContentController;
    // JS调用OC添加处理脚本
    [userCC addScriptMessageHandler:self name:@"showMobile"];
    [userCC addScriptMessageHandler:self name:@"showName"];
    [userCC addScriptMessageHandler:self name:@"showMessage"];
}

#pragma mark - <WKScriptMessageHandler>

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // NSLog(@"%@--%@", [NSThread isMainThread] ? @"主线程" : @"子线程", NSStringFromSelector(_cmd)); // 主线程
    // NSLog(@"%@--%@", message.name, message.body); // body:  Allowed types are NSNumber, NSString, NSDate, NSArray, NSDictionary, and NSNull.
    if ([message.name isEqualToString:@"showMobile"]) {
        if (message.body == nil) {
            NSLog(@"it's nil");
        }
        else if (message.body == [NSNull null]) {
            NSLog(@"it's null"); // here print
        }
        else {
            NSLog(@"%@", message.body);
        }
    }
    else if ([message.name isEqualToString:@"showName"]) {
        NSLog(@"%@", message.name);
    }
    else if ([message.name isEqualToString:@"showMessage"]) {
        NSArray *array = message.body;
        NSLog(@"%@", array);
    }
}

#pragma mark - OC call JS

- (IBAction)callJS_clear:(id)sender {
    [self.webView evaluateJavaScript:@"clear()" completionHandler:nil];
}

- (IBAction)callJS_showMobile:(id)sender {
    [self.webView evaluateJavaScript:@"showMobile('15276768876')" completionHandler:nil];
}

- (IBAction)callJS_showName:(id)sender {
        [self.webView evaluateJavaScript:@"showName('DaLiu')" completionHandler:nil];
}

- (IBAction)callJS_showMessage:(id)sender {
    [self.webView evaluateJavaScript:@"showMessage('18870707070','OK')" completionHandler:nil];
}

@end
