//
//  ReactiveCocoa.m
//  MSRAC
//
//  Created by ms on 2017/1/3.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//  ReactiveCocoa 笔记

#import <Foundation/Foundation.h>

// ReactiveCocoa 入门篇
/*
 一.ReactiveCocoa背景
 什么是RAC？
    ReactiveCocoa（其简称为RAC）是由GitHub开源的一个应用于iOS和OS X开发的新框架。RAC具有函数式编程和响应式编程的特性。简单的说，RAC就是一个第三方库，他可以大大简化你的代码过程。
 
 为什么要学习RAC？
    为了提高开发效率。RAC在某些特定情况下开发时可以大大简化代码，并且目前来看安全可靠。
 
 如何集成？ Github：ReactiveCocoa/ReactiveCocoa
 https://github.com/ReactiveCocoa/ReactiveCocoa
 
 
 使用RAC
 1.target-action  监听事件
 示例：
 // 1. 引入头文件
 #import <ReactiveCocoa/ReactiveCocoa.h>
 
 // 2.1 方法1: RAC代码 - 监听textFild的UIControlEventEditingChanged事件
 [[self.textFild rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
    NSLog(@"UIControlEventEditingChanged");
 }];
 // 2.2 方法2: 简单写法 - 监听textFild文字更改
 [[self.textFild rac_textSignal] subscribeNext:^(id x) {
    NSLog(@"x => %@", x);
 }];
 
 // 3. 给label添加手势动作
 UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
 [[tap rac_gestureSignal] subscribeNext:^(id x) {
    NSLog(@"tap label");
 }];
 [self.view addGestureRecognizer:tap];
 
 2.代理
 RAC写代理局限性：只能实现返回值为void的代理方法
 优点：简化代码
 场景：一个View有多个AlertView，每个AlertView又有很多个按钮，每个按钮都有自己的点击事件，我应该怎么写？常见写法，给每个按钮和AlertView打标记，再往代理点击事件里加各种方法，代码又臭又长。
 RAC怎么写代理方法？
 示例：
 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC TEST" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
 [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
    NSLog(@"%@", tuple.first);
    NSLog(@"%@", tuple.second);
    NSLog(@"%@", tuple.third);
 }];
 [alertView show];
 */
