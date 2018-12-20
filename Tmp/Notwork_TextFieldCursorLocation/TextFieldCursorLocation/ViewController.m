//
//  ViewController.m
//  TextFieldCursorLocation
//
//  Created by liuweizhen on 2018/11/29.
//  Copyright © 2018 DaLiu. All rights reserved.
//

#import "ViewController.h"
#import "InputingValidator.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, copy) NSString *oldText;

@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 40)];
    self.textField.borderStyle = UITextBorderStyleBezel;
    self.textField.delegate = self;
    [self.view addSubview:self.textField];
}

#pragma mark - <UITextFieldDelegate>

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [InputingValidator validatePhone:textField shouldChangeCharactersInRange:range replacementString:string];
}

@end
