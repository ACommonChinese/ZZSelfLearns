//
//  BMCommonAlertContentView.m
//  UIAlertControllerDemo
//
//  Created by liuweizhen on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "BMCommonAlertContentView.h"

@implementation BMCommonAlertContentView

- (IBAction)okButtonClick:(id)sender {
    if (self.callbackHandler) {
        self.callbackHandler();
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
