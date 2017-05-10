//
//  NetworkRequest.h
//  NormalTest
//
//  Created by Wolf on 16/3/16.
//  Copyright © 2016年 许毓方. All rights reserved.
//  自定义请求

#import "NetworkBaseRequest.h"

@interface NetworkRequest : NetworkBaseRequest


// 使用请求类

+ (void)GET:(NSString *)url
 parameters:(NSDictionary *)parameters
     isShow:(BOOL)isShow
    success:(SuccessBlock)success
    failure:(FailureBlock)failure
andViewController:(UIViewController *)controller;


+ (void)POST:(NSString *)url
  parameters:(NSDictionary *)parameters
      isShow:(BOOL)isShow
     success:(SuccessBlock)success
     failure:(FailureBlock)failure
andViewController:(UIViewController *)controller;

+ (void)Upload:(NSString *)url
    parameters:(NSDictionary *)parameters
        isShow:(BOOL)isShow
      imageKey:(NSString *)imageKey
      withData:(NSData *)data
upLoadProgress:(loadProgress)loadProgress
       success:(SuccessBlock)success
       failure:(FailureBlock)failure
andViewController:(UIViewController *)controller;



@end
