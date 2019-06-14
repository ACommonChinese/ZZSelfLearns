//
//  ViewController.m
//  JSCallback
//
//  Created by 刘威振 on 4/20/16.
//  Copyright © 2016 LiuWeiZhen. All rights reserved.
//

#import "ViewController.h"
#import "BMJSHandler.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSLog(@"%@", request.URL);
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {}

/** 1.html
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"onShare"] = ^(NSString *title ,NSString *content ,NSString *url,NSString *image) {
        NSLog(@"title==%@content==%@url==%@image= %@", title,content,url,image);
    };
}*/

// 2.html
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context=[webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"webview"] = [BMJSHandler sharedHandler];
}

- (void)web_scanQRcode:(id)obj {
    NSLog(@"called! %@", obj);
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"2" ofType:@"html"]];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

@end
