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
// *  Header Name: BMJSHandler.h
// *
// *  General Description: Copyright and file header.
// *
// *  Created by Chris on 2018/10/24.
// *
// *  JiraID: ZXQAPP-110
// *
// ****************************************************************************************/

#import <Foundation/Foundation.h>
#import "BMJSExport.h"

NS_ASSUME_NONNULL_BEGIN

@interface BMJSHandler : NSObject <BMJSExport>

/**
 * Creates and returns a 'JSHandler' object
 */
+ (BMJSHandler *)sharedHandler;

/**
 * Disable new
 */
+ (instancetype)new NS_UNAVAILABLE;

/**
 * Disable int
 */
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
