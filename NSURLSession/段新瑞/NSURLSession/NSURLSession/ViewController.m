//
//  ViewController.m
//  NSURLSession
//
//  Created by Wolf on 16/5/4.
//  Copyright © 2016年 JieShi. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "NetworkRequest.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}



- (IBAction)get:(UIButton *)sender {
    self.label.text = nil;

    [NetworkRequest GET:@"http://172.16.107.39:8081/jieshi/jieshi" parameters:@{@"ad":@"ad"} isShow:YES success:^(NSURL *requestURL, NSDictionary *requestDic) {
        self.label.text = [NSString stringWithFormat:@"%@",requestDic];
    } failure:^(NSURL *requestURL, NSString *error) {
        self.label.text = [NSString stringWithFormat:@"%@",error];
    } andViewController:self];
}
- (IBAction)post:(UIButton *)sender {
    self.label.text = nil;

    NSDictionary *dict = @{@"ad":@"sfd"};

    [NetworkRequest POST:@"http://172.16.107.39:8081/jieshi/jieshi" parameters:dict isShow:NO success:^(NSURL *requestURL, NSDictionary *requestDic) {

        self.label.text = [NSString stringWithFormat:@"%@",requestDic];
    } failure:^(NSURL *requestURL, NSString *error) {
        self.label.text = [NSString stringWithFormat:@"%@",error];
    } andViewController:self];


}
- (IBAction)image:(UIButton *)sender {
    self.label.text = nil;

//    *  appendPartWithFileURL   //  指定上传的文件
//    *  name                    //  指定在服务器中获取对应文件或文本时的key
//    *  fileName                //  指定上传文件的原始文件名
//    *  mimeType                //  指定商家文件的MIME类型

    UIImage *image  = [UIImage imageNamed:@"scan.jpg"];
    NSData *data    = UIImageJPEGRepresentation(image, 1);

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];

    [parameter setValue:@"image_liu_wei_zhen" forKey:@"name"];

    [NetworkRequest Upload:@"http://localhost:8080/StrutsDemo_2/uploadServlet" parameters:parameter isShow:NO imageKey:@"file" withData:data upLoadProgress:^(float progress) {
        NSLog(@"%f",progress);
    } success:^(NSURL *requestURL, NSDictionary *requestDic) {
       self.label.text = [NSString stringWithFormat:@"%@",requestDic];
    } failure:^(NSURL *requestURL, NSString *error) {
        self.label.text = [NSString stringWithFormat:@"%@",error];
    } andViewController:self];

}
- (IBAction)imgNO:(UIButton *)sender {
    self.label.text = nil;

    UIImage *image  = [UIImage imageNamed:@"scan.jpg"];
    NSData *data    = UIImageJPEGRepresentation(image, 1);


    [NetworkRequest Upload:@"http://172.16.107.39:8081/jieshi/upload" parameters:nil isShow:NO imageKey:@"uploadFile" withData:data upLoadProgress:^(float progress) {

    } success:^(NSURL *requestURL, NSDictionary *requestDic) {
        self.label.text = [NSString stringWithFormat:@"%@",requestDic];
    } failure:^(NSURL *requestURL, NSString *error) {
        self.label.text = [NSString stringWithFormat:@"%@",error];
    } andViewController:self];
    
}
- (IBAction)array:(UIButton *)sender {
    self.label.text = nil;

    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];

    [parameter setValue:@"json" forKey:@"json"];


    [NetworkRequest POST:@"http://172.16.107.39:8081/jieshi/jieshi" parameters:parameter isShow:NO success:^(NSURL *requestURL, NSDictionary *requestDic) {
        self.label.text = [NSString stringWithFormat:@"%@",requestDic];

    } failure:^(NSURL *requestURL, NSString *error) {
        self.label.text = [NSString stringWithFormat:@"%@",error];

    } andViewController:self];
}

@end
