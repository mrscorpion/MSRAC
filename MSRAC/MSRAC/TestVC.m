//
//  TestVC.m
//  MSRAC
//
//  Created by ms on 2017/1/3.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//  RACSubject替换代理

#import "TestVC.h"

@interface TestVC ()
@end

@implementation TestVC
#pragma mark - VIEW LIFE CYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    [self configurationUI];
}

#pragma mark - UI
- (void)configurationUI
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn addTarget:self action:@selector(notice:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - ACTIONS
// 步骤二：监听第二个控制器按钮点击
- (void)notice:(id)sender
{
    // 通知第一个控制器，告诉它，按钮被点了
    // 通知代理
    // 判断代理信号是否有值
    if (self.delegateSignal) {
        // 有值，才需要通知
        [self.delegateSignal sendNext:nil];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
