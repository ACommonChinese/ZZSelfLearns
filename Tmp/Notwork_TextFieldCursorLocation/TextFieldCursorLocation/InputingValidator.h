//
//  InputingValidator.h
//  TextFieldCursorLocation
//
//  Created by liuweizhen on 2018/12/5.
//  Copyright © 2018 banma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InputingValidator : NSObject

+ (BOOL)validatePhone:(UITextField *)inputField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end
