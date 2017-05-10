//
//  NetworkClient.h
//  JieShi
//
//  Created by Wolf on 16/5/3.
//  Copyright © 2016年 JieShi. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface NetworkClient : AFHTTPSessionManager


+ (instancetype) sharedNetworkClient;


@end
