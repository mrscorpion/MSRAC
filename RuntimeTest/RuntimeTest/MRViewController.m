//
//  MRViewController.m
//  RuntimeTest
//
//  Created by ms on 2016/1/4.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "MRViewController.h"
#import <objc/runtime.h>
#import "UIViewController+swizzling.h"

@interface MRViewController ()

@end

@implementation MRViewController
#pragma mark - VIEW LIFE CYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    // 需先调用父类 viewWillAppear:
    [super viewWillAppear:animated];
    NSLog(@"Class ==> %@", NSStringFromClass([self class]));
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
