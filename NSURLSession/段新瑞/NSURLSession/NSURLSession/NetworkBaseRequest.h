//
//  NetworkRequest.h
//  NormalTest
//
//  Created by Wolf on 16/3/4.
//  Copyright © 2016年 许毓方. All rights reserved.
//  数据请求封装

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

/**
 *  HTTP请求方式
 */
typedef NS_ENUM(NSUInteger, HTTPMethodType) {
    HTTPMethodTypeGET,
    HTTPMethodTypePOST,
    HTTPMethodTypeUpload
};


/**
 *  HTTP返回数据类型
 */
typedef NS_ENUM(NSUInteger, HTTPResponseType) {
    HTTPResponseTypeJSON,
    HTTPResponseTypeXML,
    HTTPResponseTypeTEXT,
    HTTPResponseTypeUnknown
};

typedef void (^SuccessBlock)(NSURL *requestURL, NSDictionary *requestDic);
typedef void (^FailureBlock)(NSURL *requestURL, NSString *error);
typedef void (^loadProgress)(float progress);

/**
 * 默认的超时时间
 */
static const NSTimeInterval kDefaultRequestTimeOut = 30;

#define kResponseStatusCode  @"statusCode"  // 返回的状态码
#define kResponseSuccessDomain 200          // 正常数据下发的状态码
#define kResponseDataNode @"data"           // 成功返回的数据字段
#define kResponseMessageNode @"message"     // 成功但参数错误返回的数据字段



@interface NetworkBaseRequest : NSObject

+ (instancetype)sharedRequest;

- (void)requestWithMethodType:(HTTPMethodType)methodType
                          URL:(NSString *)url
                   parameters:(NSDictionary *)parameters
                     imageKey:(NSString *)imageKey
                     withData:(NSData *)data
                   isSecurity:(BOOL)security
               requestTimeout:(NSTimeInterval)requestTimeout
                      showHUD:(BOOL)isShow
                      success:(SuccessBlock)success
               upLoadProgress:(loadProgress)loadProgress
                      failure:(FailureBlock)failure
            andViewController:(UIViewController *)controller;


@end
