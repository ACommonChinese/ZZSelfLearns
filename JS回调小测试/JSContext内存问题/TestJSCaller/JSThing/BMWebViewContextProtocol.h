//
//  BMWebViewContextProtocol.h
//  ZXQ
//
//  Created by liuweizhen on 2018/12/19.
//  Copyright © 2018 Banma. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * JS call oc method for context `webvoew`
 */
@protocol BMWebViewContextProtocol <NSObject>

- (void)callTel:(NSString *)params;


//- (void)context_webview_statAnalysis:(id)params;
//- (NSString *)context_webview_getNativeData:(NSString *)param;
//- (void)context_webview_messageToastAction:(NSString *)message;
//- (void)context_webview_dismissLoading;
//- (void)context_webview_showLoading:(NSString *)param;
//- (void)context_webview_finish:(id)param;
//- (BOOL)context_webview_isNetWorkConnected:(NSString *)param;
//- (void)context_webview_getOemToken:(NSString *)oemCode;
//- (void)context_webview_receiveLogin:(NSString *)token Status:(NSString *)vin;
//- (void)context_webview_toAlipay:(NSString *)url;
//- (BOOL)context_webview_isInstallAlipay:(id)param;
//- (void)context_webview_downAlipay:(id)param;
//- (void)context_webview_startPaySet:(id)param;
//- (void)context_webview_error:(NSInteger)type Message:(NSString *)content Handler:(NSString *)vin;
//- (NSString *)context_webview_getButtonPrimaryColor:(NSString *)param;
//- (void)context_webview_callTel:(NSString *)Tel;
//- (void)context_webview_nativeShareInter:(NSString *)result URL: (NSString *)url;
//- (void)context_webview_setNativeShareFlag:(BOOL)bShow;
//- (NSString *)context_webview_getSign:(NSString *)paramStr;
//- (NSString *)context_webview_deviceInfo:(NSString *)info;

@end

NS_ASSUME_NONNULL_END
