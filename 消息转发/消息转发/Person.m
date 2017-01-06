//
//  Person.m
//  消息转发
//
//  Created by ms on 2017/1/5.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "Person.h"
#import <objc/runtime.h>
#import "Car.h"

@implementation Person
/*****  方案一  *****/
/*！
 系统调用的两个方法：
    + (BOOL)resolveInstanceMethod:(SEL)sel
    + (BOOL)resolveClassMethod:(SEL)sel
 
 方案：
    1.实现resolveInstanceMethod:方法
    2.为Person类动态增加了一个run方法的实现.
 
 备注：什么是动态增加？
    就是在程序运行的时候给某类的某个方法增加实现。
    具体实现内容就是下面 void run 这个c函数。
 */
/*// 第一步：实现 resolveInstanceMethod: 方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    // 第二步：为 Person 类动态增加一个 run 方法的实现
    if (sel == @selector(run))
    {
        class_addMethod(self, sel, (IMP)run, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
// 第三步：run 方法的具体实现内容
void run (id self, SEL _cmd)
{
    NSLog(@"%@ ==> %s", self, sel_getName(_cmd)); // 打印当前对象与方法名
}*/



/*****  方案二  *****/
/*
 系统调用的方法:
    - (id)forwardingTargetForSelector:(SEL)aSelector
 */
// 第一步：不去对方案一的 resolveInstanceMethod 做任何处理，直接调用父类方法。
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    return [super resolveInstanceMethod:sel];
}
/*
 第二步：实现 forwardingTargetForSelector： 方法
 forwardingTargetForSelector：方法返回需要转发消息的对象
 */
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    // 第三步：返回一个 Car 类的实例对象
    return [[Car alloc] init];
}


/*****  方案三  *****/
/*！
 系统调用的两个方法：
    - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
    - (void)forwardInvocation:(NSInvocation *)anInvocation;
 备注：methodSignatureForSelector 用来生成方法签名，这个签名是给 forwardInvocation 中的参数 NSInvocation 调用的。
 
 解答：错误 unrecognized selector sent to instance 原因?
    是因为 methodSignatureForSelector 这个方法中，由于没有找到run对应的实现方法，所以返回了一个空的方法签名，最终导致程序报错崩溃。
 
 方案：所以我们需要做的是
    1.自己新建方法签名
    2.再在forwardInvocation中用你要转发的那个对象调用这个对应的签名
 从而也实现了消息转发
 */
// 不实现 forwardingTargetForSelector:,  自己新建方法签名 methodSignatureForSelector:
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    // 获取方法名
    NSString *sel = NSStringFromSelector(aSelector);
    // 判断要转发的SEL
    if ([sel isEqualToString:@"run"])
    {
        // 为自己的转发方法手动生成签名
        /*!
         每一个方法会默认隐藏两个参数: self、_cmd
            > self : 代表方法调用者
            > _cmd : 代表这个方法的SEL
         
         签名类型: 用来描述这个方法的返回值、参数的。
         释义：生成签名的类型 "v@:" 
            > v : 代表返回值为void
            > @ : 表示self
            > : : 表示_cmd
         */
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    SEL selector = [anInvocation selector];
    // 新建需要转发消息的对象
    Car *car = [[Car alloc] init];
    if ([car respondsToSelector:selector]) {
        // 唤醒这个方法
        [anInvocation invokeWithTarget:car];
    }
}
@end
