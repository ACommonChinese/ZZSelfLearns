//
//  main.m
//  NSProxyDemo_4_HttpProxy
//
//  Created by liuweizhen on 2017/11/13.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserHttpHandlerImp.h"
#import "CommentHttpHandlerImp.h"
#import "HttpProxy.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //Init and register http handler
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(UserHttpHandler) handler:[UserHttpHandlerImp new]];
        [[HttpProxy sharedInstance] registerHttpProtocol:@protocol(CommentHttpHandler) handler:[CommentHttpHandlerImp new]];
        
        //Call
        [[HttpProxy sharedInstance] getUserWithID:@100];
        [[HttpProxy sharedInstance] getCommentsWithDate:[NSDate new]];
    }
    return 0;
}
