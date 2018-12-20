//
//  BaseWebViewController.m
//  TestJSCaller
//
//  Created by liuweizhen on 2018/12/19.
//  Copyright © 2018 banma. All rights reserved.
//

#import "BaseWebViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "BMJSHandler.h"
#import "BMWebView.h"

JS_EXPORT void JSSynchronousGarbageCollectForDebugging(JSContextRef ctx);

@interface JSContext (GarbageCollection)

- (void)garbageCollect;

@end

@implementation JSContext (GarbageCollection)

- (void)garbageCollect {
    JSSynchronousGarbageCollectForDebugging(self.JSGlobalContextRef);
}

@end

@interface BaseWebViewController () <UIWebViewDelegate, BMJSHandlerProtocol>

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.baseWebView];
    
    NSString *htmlString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    [self.baseWebView loadHTMLString:htmlString baseURL:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.baseWebView.frame = self.view.bounds;
}

- (BMWebView *)baseWebView {
    if (_baseWebView == nil) {
        _baseWebView = [[BMWebView alloc]init];
        _baseWebView.delegate = self;
        _baseWebView.backgroundColor = [UIColor whiteColor];
        _baseWebView.scalesPageToFit = YES;
    }
    return _baseWebView;
}

#pragma mark - UIWebView Delegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
     [self loadJsContext];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self loadJsContext];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"web view load fail.");
}

- (void)loadJsContext{
    // http://www.voidcn.com/article/p-ztsvbecm-vm.html
    JSContext *webViewContext = [self.baseWebView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // Add JS Export target
    // webViewContext[@"webview"] = [BMJSHandler sharedHandler];
    // [webViewContext setObject:weakSelf forKeyedSubscript:@"webview"];
    
    webViewContext[@"webview"] = [[BMJSHandler alloc] initWithDelegate:self];
    
    // webViewContext[@"webview"] = self;
    
    // https://stackoverflow.com/questions/35689482/force-garbage-collection-of-javascriptcore-virtual-machine-on-ios
    // [webViewContext garbageCollect];
}

- (void)dealloc {
    NSLog(@"BaseWebViewController dealloc");
}

@end

