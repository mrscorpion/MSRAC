//
//  ViewController.m
//  RuntimeTest
//
//  Created by ms on 2016/1/4.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "ViewController.h"
#import <objc/runtime.h>
#import "MRViewController.h"

// test runtime
#import "TestObj.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray *arrM;
@end

@implementation ViewController
#pragma mark - VIEW LIFE CYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    // _cmd 代表本方法的名称
    // “The _cmd variable is a hidden argument passed to every method that is the current selector”，其实说的就是_cmd在Objective-C的方法中表示当前方法的selector，正如同self表示当前方法调用的对象实例一样。
    /*
     Objective-C的编译器在编译后会在每个方法中加两个隐藏的参数:
     一个是_cmd，当前方法的一个SEL指针。
     另一个就是用的比较多的self，指向当前对象的一个指针。
     */
    NSLog(@"Current method: %@ %@",[self class], NSStringFromSelector(_cmd));
    // Current method: ViewController viewDidLoad
    
    //二、交换方法
    [self testExchange];
    
    // test runtime
    [self enumIvars];
    [self enumMethodList];
    [self enumPropertyList];
}


// 方法交换
// 在一个自己定义的viewController中重写viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"==> viewWillAppear");
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeInfoDark];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    
    NSLog(@"===> %@ %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
}




// test
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self presentViewController:[[MRViewController alloc] init] animated:YES completion:nil];
}




// test runtime
//获取成员变量列表
- (void)enumIvars
{
    /** 利用runtime遍历一个类的全部成员变量
     1.导入头文件<objc/runtime.h>     */
    unsigned int count = 0;
    /** Ivar:表示成员变量类型 */
    Ivar *ivars = class_copyIvarList([TestObj class], &count);//获得一个指向该类成员变量的指针
    for (int i =0; i < count; i ++) {
        //获得Ivar
        Ivar ivar = ivars[i];        //根据ivar获得其成员变量的名称--->C语言的字符串
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        NSLog(@"%d----%@",i,key);
    }
}
// 获取方法列表
- (void)enumMethodList
{
    unsigned int count = 0;
    //获取方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i; i < count; i++)
    {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
}
// 获取属性列表
- (void)enumPropertyList
{
    unsigned int count = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++)
    {
        const char *propertyName = property_getName(propertyList[i]);
        NSLog(@"property---->%@", [NSString stringWithUTF8String:propertyName]);
    }
}
// 获取协议列表
- (void)enumProtocolList
{
    unsigned int count = 0;
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i; i < count; i++)
    {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
}







//二、交换方法
/*
 通过runtime的method_exchangeImplementations(Method m1, Method m2)方法，可以进行交换方法的实现；一般用自己写的方法（常用在自己写的框架中，添加某些防错措施）来替换系统的方法实现，常用的地方有：
 
 在数组中，越界访问程序会崩，可以用自己的方法添加判断防止程序出现崩溃数组或字典中不能添加nil，如果添加程序会崩，用自己的方法替换系统防止系统崩溃
 */
- (void)testExchange
{
    self.arrM = [NSMutableArray array];
    [self.arrM addObject:@"mr"];
    [self.arrM addObject:@"ms"];
    [self.arrM addObject:nil];
    
    NSLog(@"==> %@", self.arrM);
    // *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
