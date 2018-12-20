//
//  BaseWebViewController.h
//  TestJSCaller
//
//  Created by liuweizhen on 2018/12/19.
//  Copyright © 2018 banma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMJSExport.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseWebViewController : UIViewController <BMJSExport>

@property (nonatomic,strong) UIWebView * baseWebView;

- (void)loadJsContext;

@end

NS_ASSUME_NONNULL_END
