//
//  ViewController.m
//  TextFieldCursorLocation
//
//  Created by liuweizhen on 2018/11/29.
//  Copyright © 2018 DaLiu. All rights reserved.
//

#import "ViewController.h"
#import "BMTextField.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet BMTextField *textField;
@property (nonatomic, copy) NSString *oldText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.maxLength = 11;
    _textField.digits = @"0123456789";
}

@end
