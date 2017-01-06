//
//  ViewController.m
//  消息转发
//
//  Created by ms on 2017/1/5.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()
@end

@implementation ViewController
#pragma mark - VIEW LIFE CYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Objective-C消息转发
    /*
     示例：
        向 Person 对象发送消息 
        Person 中 run 方法只有定义没有实现
     
     运行：
        *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[Person run]: unrecognized selector sent to instance 0x600000013cd0'
     */
    Person *p = [[Person alloc] init];
    [p run];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
