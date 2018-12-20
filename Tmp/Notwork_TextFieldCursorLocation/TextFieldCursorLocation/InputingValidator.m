//
//  InputingValidator.m
//  TextFieldCursorLocation
//
//  Created by liuweizhen on 2018/12/5.
//  Copyright © 2018 banma. All rights reserved.
//

#import "InputingValidator.h"

@implementation InputingValidator

// 1lI0Oo
// abc
// ABC

+ (BOOL)validatePhone:(UITextField *)inputField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)rangeString {
    if ([self isNullOrEmpty:rangeString]) {
        return YES;
    }
    else {
        NSString *text = inputField.text;
        NSString *replaceString = [self getNumber:rangeString];
        if ([self isNullOrEmpty:replaceString]) {
            return NO;
        }
        if (replaceString.length + inputField.text.length <= 11 && [replaceString isEqualToString:rangeString]) {
            return YES;
        }
        NSInteger limitLength = MAX(0, 11 - (text.length - range.length));
        if (limitLength <= 0) {
            return NO;
        }
        replaceString = [replaceString substringToIndex:MIN(limitLength, replaceString.length)];
        [self textField:inputField replaceString:replaceString forRange:range];
        return NO;
    }
}

+ (void)textField:(id<UITextInput>)inputField replaceString:(NSString *)replaceString forRange:(NSRange)range {
    UITextPosition *beginning = inputField.beginningOfDocument;
    UITextPosition *start = [inputField positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [inputField positionFromPosition:start offset:range.length];
    UITextRange *textRange = [inputField textRangeFromPosition:start toPosition:end];
    
    // this will be the new cursor location after insert/paste/typing
    NSInteger cursorOffset = [inputField offsetFromPosition:beginning toPosition:start] + replaceString.length;
    
    [inputField replaceRange:textRange withText:replaceString];
    
    // https://stackoverflow.com/questions/11157791/how-to-move-cursor-in-uitextfield-after-setting-its-value
    // setText:或replaceRange:withText:之后马上setCursor位置错乱，Weired.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UITextPosition *newCursorPosition = [inputField positionFromPosition:inputField.beginningOfDocument offset:cursorOffset];
        UITextRange *newSelectedRange = [inputField textRangeFromPosition:newCursorPosition toPosition:newCursorPosition];
        [inputField setSelectedTextRange:newSelectedRange];
    });
}

+ (NSString *)getNumber:(NSString *)originStr {
    if (!originStr || originStr.length <= 0 || [originStr isKindOfClass:[NSNull class]]) {
        return nil;
    }
    NSMutableString *replaceStr = [NSMutableString stringWithCapacity:originStr.length];
    for (NSInteger i = 0; i < originStr.length; i++) {
        NSString *subStr = [originStr substringWithRange:NSMakeRange(i, 1)];
        if ([self containsOnlyNumbers:subStr]) {
            [replaceStr appendString:subStr];
        }
    }
    if ([self isNullOrEmpty:replaceStr]) {
        return nil;
    }
    return replaceStr;
}

// 此代码可放在NSString+XXX中，声明为：- (BOOL)isNullOrEmpty;
+ (BOOL)isNullOrEmpty:(NSString *)string {
    if (!string || string.length <= 0 || [string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

// 此代码可放在NSString+XXX中, 声明为：- (BOOL)containsOnlyNumbers;
+ (BOOL)containsOnlyNumbers:(NSString *)string {
    NSCharacterSet *numbers = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([string rangeOfCharacterFromSet:numbers].location == NSNotFound);
}

@end
