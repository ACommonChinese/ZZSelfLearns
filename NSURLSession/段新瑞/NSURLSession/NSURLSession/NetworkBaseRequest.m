//
//  NetworkRequest.m
//  NormalTest
//
//  Created by Wolf on 16/3/4.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "NetworkBaseRequest.h"
#import <UIKit/UIKit.h>
#import "NetworkClient.h"
#import "MBProgressHUD.h"
#warning  发散性思维  1. \
                    2. 加密 \
                    3. 有没有必要单例, 不好的地方;  \
                    4. 加载动画类型, 导航要不要


@interface NetworkBaseRequest ()

@end


@implementation NetworkBaseRequest


+ (instancetype)sharedRequest
{
    return [[self alloc] init];
}


#pragma mark - 统一请求
/**
 *  网络请求
 *
 *  @param methodType     请求方式(GET,POST,Upload)
 *  @param url            请求地址
 *  @param parameters     请求参数
 *  @param imageKey       指定在服务器中获取对应文件或文本时的key
 *  @param data           要上传的数据
 *  @param security       是否加密
 *  @param requestTimeout 超时
 *  @param isShow         加载动画
 *  @param success        成功回调
 *  @param loadProgress   进度回调
 *  @param failure        失败回调
 *  @param controller     请求的控制器(用于吐司)
 */
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
            andViewController:(UIViewController *)controller
{
    // 处理中文和空格问题
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

    // 网络
    [self networkPerformWithController:controller];

    // 加载动画
    MBProgressHUD *hud ;
    if (isShow) {
        hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        hud.labelText = @"Loading...";
    }
    // config;
    NetworkClient *manager = [NetworkClient sharedNetworkClient];

    manager.requestSerializer.timeoutInterval = (requestTimeout > 0) ? requestTimeout : kDefaultRequestTimeOut;

    switch (methodType) {
        case HTTPMethodTypeGET: {
            // 拼接URL
            url = [self urlDictToStringWithUrlStr:url WithDict:parameters];

            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                loadProgress((float)downloadProgress.completedUnitCount/(float)downloadProgress.totalUnitCount);

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = (NSDictionary *)responseObject;
                if (isShow)  [hud hide:YES];
                if (!dict) failure(task.originalRequest.URL, @"数据为空");
                if ([dict[kResponseStatusCode] integerValue] == kResponseSuccessDomain)
                    success(task.originalRequest.URL, dict[kResponseDataNode]);
                else
                    [self errorPerformController:controller message:dict[kResponseMessageNode]];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (isShow)  [hud hide:YES];
                failure(task.originalRequest.URL, error.localizedDescription);

            }];
            break;
        }
        case HTTPMethodTypePOST: {
            [manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
//                loadProgress((float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount);

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = (NSDictionary *)responseObject;
                if (isShow)  [hud hide:YES];
                if (!dict) failure(task.originalRequest.URL, @"数据为空");
                if ([dict[kResponseStatusCode] integerValue] == kResponseSuccessDomain)
                    success(task.originalRequest.URL, dict[kResponseDataNode]);
                else
                    [self errorPerformController:controller message:dict[kResponseMessageNode]];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (isShow)  [hud hide:YES];
                failure(task.originalRequest.URL, error.localizedDescription);

            }];
            break;
        }
        case HTTPMethodTypeUpload: {
            [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                NSTimeInterval timeInterVal = [[NSDate date] timeIntervalSince1970];
                NSString * fileName = [NSString stringWithFormat:@"%@.png",@(timeInterVal)];
                [formData appendPartWithFileData:data name:imageKey fileName:fileName mimeType:@"image/jpg"];

            } progress:^(NSProgress * _Nonnull uploadProgress) {
                loadProgress((float)uploadProgress.completedUnitCount/(float)uploadProgress.totalUnitCount);

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *dict = (NSDictionary *)responseObject;
                if (isShow)  [hud hide:YES];
                if (!dict) failure(task.originalRequest.URL, @"数据为空");
                if ([dict[kResponseStatusCode] integerValue] == kResponseSuccessDomain)
                    success(task.originalRequest.URL, dict[kResponseDataNode]);
                else
                    [self errorPerformController:controller message:dict[kResponseMessageNode]];

            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (isShow)  [hud hide:YES];
                failure(task.originalRequest.URL, error.localizedDescription);

            }];
            break;
        }
    }

}

#pragma mark - 拼接GET参数
- (NSString *)urlDictToStringWithUrlStr:(NSString *)urlStr WithDict:(NSDictionary *)parameters
{
    if (!parameters)  return urlStr;

    NSMutableArray *parts = [NSMutableArray array];
    // enumerateKeysAndObjectsUsingBlock会遍历dictionary并把里面所有的key和value一组一组的展示给你，每组都会执行这个block 这其实就是传递一个block到另一个方法，在这个例子里它会带着特定参数被反复调用，直到找到一个ENOUGH的key，然后就会通过重新赋值那个BOOL *stop来停止运行，停止遍历同时停止调用block
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        // 接收key
        NSString *finalKey = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        // 接收值
        NSString *finalValue = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];

        NSString *part =[NSString stringWithFormat:@"%@=%@",finalKey,finalValue];

        [parts addObject:part];
    }];

    NSString *queryString = [parts componentsJoinedByString:@"&"];

    queryString = queryString ? [NSString stringWithFormat:@"?%@",queryString] : @"";

    NSString *pathStr = [NSString stringWithFormat:@"%@?%@",urlStr,queryString];

    return pathStr;
}


#pragma mark - 处理不同网络
- (void)networkPerformWithController:(UIViewController *)viewController
{
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    NSLog(@"%ld",mgr.networkReachabilityStatus);
}

#pragma mark - 处理错误
- (void)errorPerformController:(UIViewController *)controller message:(NSString *)message
{
    if (![message isKindOfClass:[NSNull class]])
    {
        if (message.length > 0)
        {
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"Loading";
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [hud hide:YES];
            });
        }
    }
}

@end
