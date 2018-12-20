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
// *  Header Name: BMJSExport.h
// *
// *  General Description: Copyright and file header.
// *
// *  Created by Chris on 2018/10/24.
// *
// *  JiraID: ZXQAPP-110
// *
// ****************************************************************************************/

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BMJSExport <JSExport>

JSExportAs(callTel, -(void)callTel:(NSString *)params);
JSExportAs(eat, -(void)eat:(NSString *)food);

@end

NS_ASSUME_NONNULL_END
