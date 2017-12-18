//
//  BMCommonAlertContentView.h
//  UIAlertControllerDemo
//
//  Created by liuweizhen on 2017/12/18.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMCommonAlertContentView : UIView

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, copy) dispatch_block_t callbackHandler;

@end
