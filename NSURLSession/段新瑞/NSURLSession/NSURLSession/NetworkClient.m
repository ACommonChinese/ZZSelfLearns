//
//  NetworkClient.m
//  JieShi
//
//  Created by Wolf on 16/5/3.
//  Copyright © 2016年 JieShi. All rights reserved.
//

#import "NetworkClient.h"


static NSString * const AFNetAPIBaseURLString = @"http://172.16.107.39:8081/jieshi";

@implementation NetworkClient

+ (instancetype) sharedNetworkClient
{
    static NetworkClient *_sharedNetworkClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedNetworkClient = [NetworkClient manager];
        _sharedNetworkClient.requestSerializer = [AFJSONRequestSerializer serializer];
    });

    return _sharedNetworkClient;
}

/*
    _sharedNetworkClient = [NetworkClient manager];
    _sharedNetworkClient.requestSerializer = [AFJSONRequestSerializer serializer];
    _sharedNetworkClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    _sharedNetworkClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain" ,@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
*/

//    [NSSet setWithObjects:@"text/plain" ,@"application/json", @"text/json", @"text/javascript",@"text/html",@"image/png",@"image/jpeg",@"application/rtf",@"image/gif",@"application/zip",@"audio/x-wav",@"image/tiff",@" 	application/x-shockwave-flash",@"application/vnd.ms-powerpoint",@"video/mpeg",@"video/quicktime",@"application/x-javascript",@"application/x-gzip",@"application/x-gtar",@"application/msword",@"text/css",@"video/x-msvideo",@"text/xml", nil];
@end
