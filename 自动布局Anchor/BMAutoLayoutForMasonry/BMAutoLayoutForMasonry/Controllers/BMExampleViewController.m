//
//  BMExampleViewController.m
//  BMAutoLayoutForMasonry
//
//  Created by liuweizhen on 2019/2/11.
//  Copyright © 2019 liuxing8807@126.com. All rights reserved.
//

#import "BMExampleViewController.h"

@interface BMExampleViewController ()

@property (nonatomic, strong) Class viewClass;

@end

@implementation BMExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (id)initWithTitle:(NSString *)title viewClass:(Class)viewClass {
    self = [super init];
    if (!self) return nil;
    
    self.title = title;
    self.viewClass = viewClass;
    
    return self;
}

- (void)loadView {
    self.view = self.viewClass.new;
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
