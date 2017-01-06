//
//  Car.m
//  消息转发
//
//  Created by ms on 2017/1/5.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "Car.h"

@implementation Car
/*****  方案二／（三）  *****/
// 第四／（三）步：实现 run 方法
- (void)run
{
    // 我们调用的是Person类的run方法，最终方法被Car类的对象来接受。这就是OC的消息转发机制。
    NSLog(@"==> car run");
}
@end
