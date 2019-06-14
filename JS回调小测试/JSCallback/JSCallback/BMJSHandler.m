///***************************************************************************************
// *
// *  Project:        ZXQ
// *
// *  Copyright ©     2014-2018 Banma Technologies Co.,Ltd
// *                  All rights reserved.
// *
// *  This software is supplied only under the terms of a license agreement,
// *  nondisclosure agreement or other written agreement with Banma Technologies
// *  Co.,Ltd. Use, redistribution or other disclosure of any parts of this
// *  software is prohibited except in accordance with the terms of such written
// *  agreement with Banma Technologies Co.,Ltd. This software is confidential
// *  and proprietary information of Banma Technologies Co.,Ltd.
// *
// ***************************************************************************************
// *
// *  Header Name: BMJSHandler.m
// *
// *  General Description: Copyright and file header.
// *
// *  Created by Chris on 2018/10/24.
// *
// *  JiraID: ZXQAPP-110
// *
// ****************************************************************************************/

#import "BMJSHandler.h"
#import "BMJSExport.h"

@implementation BMJSHandler

+ (BMJSHandler *)sharedHandler {
    static BMJSHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


// Native information
- (void)getNativeData:(NSString *)param {
    NSLog(@"...........got it: %@", param);
}


@end
