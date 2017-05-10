//
//  NetworkRequest.m
//  NormalTest
//
//  Created by Wolf on 16/3/16.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "NetworkRequest.h"

@implementation NetworkRequest

+ (void)GET:(NSString *)url parameters:(NSDictionary *)parameters isShow:(BOOL)isShow success:(SuccessBlock)success failure:(FailureBlock)failure andViewController:(UIViewController *)controller
{
    return [[super sharedRequest] requestWithMethodType:HTTPMethodTypeGET URL:url parameters:parameters imageKey:nil withData:nil isSecurity:NO requestTimeout:kDefaultRequestTimeOut showHUD:isShow success:success upLoadProgress:nil failure:failure andViewController:controller];
}


+ (void)POST:(NSString *)url parameters:(NSDictionary *)parameters isShow:(BOOL)isShow success:(SuccessBlock)success failure:(FailureBlock)failure andViewController:(UIViewController *)controller
{
    return [[super sharedRequest] requestWithMethodType:HTTPMethodTypePOST URL:url parameters:parameters imageKey:nil withData:nil isSecurity:NO requestTimeout:kDefaultRequestTimeOut showHUD:isShow success:success upLoadProgress:nil failure:failure andViewController:controller];
}

+ (void)Upload:(NSString *)url parameters:(NSDictionary *)parameters isShow:(BOOL)isShow imageKey:(NSString *)imageKey withData:(NSData *)data upLoadProgress:(loadProgress)loadProgress success:(SuccessBlock)success failure:(FailureBlock)failure andViewController:(UIViewController *)controller
{
    return [[super sharedRequest] requestWithMethodType:HTTPMethodTypeUpload URL:url parameters:parameters imageKey:imageKey withData:data isSecurity:NO requestTimeout:kDefaultRequestTimeOut showHUD:isShow success:success upLoadProgress:loadProgress failure:failure andViewController:controller];
}

@end
