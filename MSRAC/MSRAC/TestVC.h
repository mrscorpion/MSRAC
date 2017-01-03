//
//  TestVC.h
//  MSRAC
//
//  Created by ms on 2017/1/3.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface TestVC : UIViewController
// 步骤一：在第二个控制器.h，添加一个RACSubject代替代理
@property (nonatomic, strong) RACSubject *delegateSignal;
@end
