//
//  BePeripheralController.m
//  Demo
//
//  Created by liuweizhen on 2017/12/7.
//  Copyright © 2017年 liuxing8807@126.com. All rights reserved.
//

#import "BePeripheralController.h"
#import <CoreBluetooth/CoreBluetooth.h>

static NSString *const ServiceUUID1 =  @"FFF0";
static NSString *const notiyCharacteristicUUID =  @"FFF1";
static NSString *const readwriteCharacteristicUUID =  @"FFF2";
static NSString *const ServiceUUID2 =  @"FFE0";
static NSString *const readCharacteristicUUID =  @"FFE1";
static NSString * const LocalNameKey =  @"myPeripheral";

@interface BePeripheralController () <CBPeripheralManagerDelegate> {
    // 外设管理器
    CBPeripheralManager *peripheralManager;
    // 定时器
    NSTimer *timer;
    // 添加成功的service数量
    int serviceNum;
    UILabel *info;
}

@end

@implementation BePeripheralController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     和CBCentralManager类似，蓝牙设备打开需要一定时间，打开成功后会进入委托方法
     - (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral;
     模拟器永远也不会得CBPeripheralManagerStatePoweredOn状态
     */
    peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil];
    
    // 页面样式
    [self.view setBackgroundColor:[UIColor whiteColor]];
    info = [[UILabel alloc]initWithFrame:self.view.frame];
    [info setText:@"正在打开设备"];
    [info setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:info];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [peripheralManager stopAdvertising];
}

// 配置bluetooch
- (void)setUp {
    // characteristics字段描述
    CBUUID *CBUUIDCharacteristicUserDescriptionStringUUID = [CBUUID UUIDWithString:CBUUIDCharacteristicUserDescriptionString];
    // Characteristic User Description
    /*
     可以通知的Characteristic
     properties：CBCharacteristicPropertyNotify
     permissions CBAttributePermissionsReadable
     */
    CBMutableCharacteristic *notiyCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:notiyCharacteristicUUID] properties:CBCharacteristicPropertyNotify value:nil permissions:CBAttributePermissionsReadable];
    
    /*
     可读写的characteristics
     properties：CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable | CBAttributePermissionsWriteable
     */
    CBMutableCharacteristic *readwriteCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readwriteCharacteristicUUID] properties:CBCharacteristicPropertyWrite | CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable | CBAttributePermissionsWriteable];
    
    // 设置description
    CBMutableDescriptor *readwriteCharacteristicDescription1 = [[CBMutableDescriptor alloc] initWithType:CBUUIDCharacteristicUserDescriptionStringUUID value:@"name"];
    [readwriteCharacteristic setDescriptors:@[readwriteCharacteristicDescription1]];
    
    /*
     只读的Characteristic
     properties：CBCharacteristicPropertyRead
     permissions CBAttributePermissionsReadable
     */
    CBMutableCharacteristic *readCharacteristic = [[CBMutableCharacteristic alloc]initWithType:[CBUUID UUIDWithString:readCharacteristicUUID] properties:CBCharacteristicPropertyRead value:nil permissions:CBAttributePermissionsReadable];
    
    // service1初始化并加入两个characteristics
    CBMutableService *service1 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID1] primary:YES];
    NSLog(@"%@",service1.UUID);
    [service1 setCharacteristics:@[notiyCharacteristic,readwriteCharacteristic]];
    
    // service2初始化并加入一个characteristics
    CBMutableService *service2 = [[CBMutableService alloc]initWithType:[CBUUID UUIDWithString:ServiceUUID2] primary:YES];
    [service2 setCharacteristics:@[readCharacteristic]];
    
    // 添加后就会调用代理的- (void)peripheralManager:(CBPeripheralManager *)peripheral didAddService:(CBService *)service error:(NSError *)error
    [peripheralManager addService:service1];
    [peripheralManager addService:service2];
}

#pragma mark - <CBPeripheralManagerDelegate>
// peripheralManager状态改变
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral {
    switch (peripheral.state) {
        // 在这里判断蓝牙设别的状态  当开启了则可调用  setUp方法(自定义)
        case CBManagerStatePoweredOn:
            NSLog(@"powered on");
            [info setText:[NSString stringWithFormat:@"设备名%@已经打开，可以使用center进行连接",LocalNameKey]];
            [self setUp];
            break;
        case CBPeripheralManagerStatePoweredOff:
            NSLog(@"powered off");
            [info setText:@"powered off"];
            break;
            
        default:
            break;
    }
}



@end
