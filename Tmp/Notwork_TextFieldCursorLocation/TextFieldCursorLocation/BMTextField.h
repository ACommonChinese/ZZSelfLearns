///***************************************************************************************
// *
// *  Project:        DaLiu
// *
// *  Copyright ©     2014-2018年 liuxing8807@126.com
// *                  All rights reserved.
// *
// *  This software is supplied only under the terms of a license agreement,
// *  nondisclosure agreement or other written agreement with DaLiu Technologies
// *  Co.,Ltd. Use, redistribution or other disclosure of any parts of this
// *  software is prohibited except in accordance with the terms of such written
// *  agreement with liuxing8807@126.com. This software is confidential
// *  and proprietary information of liuxing8807@126.com.
// *
// ***************************************************************************************
// *
// *  Header Name: BMTextField.h
// *
// *  General Description: Copyright and file header.
// *
// *  Created by liuweizhen on 2018/3/15.
// *
// ****************************************************************************************/

#import <UIKit/UIKit.h>

/**
 * BMTextField 继承于UITextField
 * 输入状态回调以及错误状态的显示
 */
@interface BMTextField : UITextField

/// 允许输入的字符集合
@property (nonatomic, copy) NSString *digits;

/// 允许输入的最大长度
@property (nonatomic, assign) NSUInteger maxLength;

/**
 * 设置光标位置
 *
 * @param idx 光标位置
 */
- (void)setCursor:(NSInteger)idx;

@end
