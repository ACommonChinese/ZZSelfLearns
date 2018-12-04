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
// *  Header Name: BMTextField.m
// *
// *  General Description: Copyright and file header.
// *
// *  Created by liuweizhen on 2018/3/15.
// *
// ****************************************************************************************/

#import "BMTextField.h"

#ifndef BMEnableLog
#define BMEnableLog 1
#define BMLog NSLog
#endif

@interface BMTextField ()

@property (nonatomic, copy) NSString *oldText;
@property (nonatomic, copy) NSString *currentText;

@end

@implementation BMTextField

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self addInputNotifications];
}

- (void)addInputNotifications {
    [self removeInputNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditingNotification:) name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangedNotification:) name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingNotification:) name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)removeInputNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:self];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidEndEditingNotification object:self];
}

- (void)textFieldDidBeginEditingNotification:(NSNotification *)notification {
    self.oldText = [self text];
}

- (void)textFieldDidChangedNotification:(NSNotification *)notification {
    if (self.markedTextRange) {
        BMLog(@"get marked text range, do nothing.");
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self resetTextWithDigitsCompletion:^{
        [weakSelf resetTextWithMaxLengthCompletion:^{
            [weakSelf didEndChangeText];
        }];
    }];
}

- (void)textFieldDidEndEditingNotification:(NSNotification *)notification {
    [self didEndChangeText];
}

- (void)didEndChangeText {
    self.oldText = [self text];
}

- (void)resetTextWithDigitsCompletion:(dispatch_block_t)completion {
    if (!self.digits || self.digits.length <= 0 || self.text.length < self.oldText.length) {
        if (completion) {
            completion();
        }
        return;
    }
    
    NSString *text = self.text;
    if (text.length > 0) {
        NSMutableString *mText = [NSMutableString string];
        NSInteger invalidCharCount = 0;
        NSInteger firstInvalid = NSNotFound;
        for (NSInteger i = 0; i < text.length; i++) {
            NSString *charStr = [text substringWithRange:NSMakeRange(i, 1)];
            if ([self.digits containsString:charStr]) {
                [mText appendString:charStr];
            }
            // f g
            // f g
            else {
                if (firstInvalid == NSNotFound) {
                    firstInvalid = i;
                }
                ++invalidCharCount;
            }
        }
        if (![text isEqualToString:mText]) {
            NSInteger cursorIdx = [self currentCursor];
            BMLog(@"current cursor index: %d", (int)cursorIdx);
            BMLog(@"invalid character count: %d", (int)invalidCharCount);
            [self setText:mText];
            
            cursorIdx = cursorIdx - invalidCharCount;
            BMLog(@"reset cursor index: %d", (int)cursorIdx);
            
            [self resetCursor:cursorIdx isDelay:YES completion:completion];
        }
        else {
            if (completion) {
                completion();
            }
        }
    }
}

- (void)resetCursor:(NSInteger)idx isDelay:(BOOL)delay completion:(dispatch_block_t)completion {
    if (delay) {
        // Weired, can't set cursor immediately after setText:
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setCursor:idx];
            if (completion) {
                completion();
            }
        });
    }
    else {
        [self setCursor:idx];
        if (completion) {
            completion();
        }
    }
}

- (void)resetTextWithMaxLengthCompletion:(dispatch_block_t)completion {
    if (self.maxLength <= 0 || self.text.length <= self.maxLength || self.text.length < self.oldText.length) {
        if (completion) {
            completion();
            return;
        }
        return;
    }
    NSString *text = self.text;
    NSMutableString *mText = [NSMutableString string];
    NSInteger cursorIdx = [self currentCursor];
    NSInteger deleteStep = self.text.length - self.maxLength;
    NSInteger fixedCursorIdx = cursorIdx - deleteStep;
    if (fixedCursorIdx <= text.length) {
        [mText appendString:[text substringWithRange:NSMakeRange(0, fixedCursorIdx)]];
        [mText appendString:[text substringFromIndex:cursorIdx]];
        
        self.text = mText;
        [self resetCursor:fixedCursorIdx isDelay:YES completion:completion];
    }
}

- (NSUInteger)countsOfString:(NSString *)string inText:(NSString *)text {
    return [text length] - [text stringByReplacingOccurrencesOfString:string withString:@""].length;
}

- (NSInteger)currentCursor {
    UITextRange *selRange = self.selectedTextRange;
    UITextPosition *selStartPos = selRange.start;
    NSInteger idx = [self offsetFromPosition:self.beginningOfDocument toPosition:selStartPos];
    return idx;
}

- (void)setCursor:(NSInteger)idx {
    if (idx < 0) {
        return;
    }
    
    [self setSelectedRange:NSMakeRange(idx, 0)];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *start = [self positionFromPosition:[self beginningOfDocument] offset:range.location];
    UITextPosition *end = [self positionFromPosition:start offset:range.length];
    [self setSelectedTextRange:[self textRangeFromPosition:start toPosition:end]];
}

- (void)dealloc {
    [self removeInputNotifications];
}

@end
