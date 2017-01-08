//
//  NSMutableArray+swizzling.m
//  RuntimeTest
//
//  Created by ms on 2016/1/4.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "NSMutableArray+swizzling.h"
#import <objc/runtime.h>

@implementation NSMutableArray (swizzling)
// load 方法在类／分类 第一次加载内存的时候自动调用
+ (void)load
{
    // __NSArrayM 是 NSMutableArray 真正的类型
    Method oriMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method impMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(imp_addObject:));
    /** 交换方法的实现 **/
    method_exchangeImplementations(oriMethod, impMethod);
}
/** 自己方法的实现 **/
- (void)imp_addObject:(id)object
{
    if (object != nil) {
        // 注意：该方法的调用，因为方法实现已经交换了，如果没有会出现死循环
        [self imp_addObject:object];
    }
}
@end
