//
//  RACVC.m
//  MSRAC
//
//  Created by ms on 2017/1/3.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "RACVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACReturnSignal.h>

@interface RACVC ()
@property (nonatomic, strong) UITextField *textField;
@end

@implementation RACVC
#pragma mark - VIEW LIFE CYCLE
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // UI
    [self configurationUI];
    
//    // 2.1 ReactiveCocoa核心方法bind (绑定)
//    [self bindDemo];
    
    // 2.2 ReactiveCocoa操作方法之映射(flattenMap,Map)
    [self mapDemo];
}

#pragma mark - UI
- (void)configurationUI
{
    self.view.backgroundColor = [UIColor orangeColor];
    
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:textField];
    textField.layer.borderColor = [UIColor blueColor].CGColor;
    self.textField = textField;
}

#pragma mark - ReactiveCocoa核心方法bind (绑定)
// 场景：假设想监听文本框的内容，并且在每次输出结果的时候，都在文本框的内容拼接一段文字“输出：”
- (void)bindDemo
{
    /*// 方式一:在返回结果后，拼接。
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"输出:%@",x);
    }];
    */
    
    // 方式二:在返回结果前，拼接，使用RAC中bind方法做处理。
    // bind方法参数:需要传入一个返回值是RACStreamBindBlock的block参数
    // RACStreamBindBlock是一个block的类型，返回值是信号，参数（value,stop），因此参数的block返回值也是一个block。
    
    // RACStreamBindBlock:
    // 参数一(value):表示接收到信号的原始值，还没做处理
    // 参数二(*stop):用来控制绑定Block，如果*stop = yes,那么就会结束绑定。
    // 返回值：信号，做好处理，在通过这个信号返回出去，一般使用RACReturnSignal,需要手动导入头文件RACReturnSignal.h。
    
    // bind方法使用步骤:
    // 1.传入一个返回值RACStreamBindBlock的block。
    // 2.描述一个RACStreamBindBlock类型的bindBlock作为block的返回值。
    // 3.描述一个返回结果的信号，作为bindBlock的返回值。
    // 注意：在bindBlock中做信号结果的处理。
    
    // 底层实现:
    // 1.源信号调用bind,会重新创建一个绑定信号。
    // 2.当绑定信号被订阅，就会调用绑定信号中的didSubscribe，生成一个bindingBlock。
    // 3.当源信号有内容发出，就会把内容传递到bindingBlock处理，调用bindingBlock(value,stop)
    // 4.调用bindingBlock(value,stop)，会返回一个内容处理完成的信号（RACReturnSignal）。
    // 5.订阅RACReturnSignal，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
    
    // 注意:不同订阅者，保存不同的nextBlock，看源码的时候，一定要看清楚订阅者是哪个。
    // 这里需要手动导入#import <ReactiveCocoa/RACReturnSignal.h>，才能使用RACReturnSignal。
    [[self.textField.rac_textSignal bind:^RACStreamBindBlock{
        // 什么时候调用:
        // block作用:表示绑定了一个信号.
        return ^RACStream *(id value, BOOL *stop){
            // 什么时候调用block:当信号有新的值发出，就会来到这个block。
            // block作用:做返回值的处理
            // 做好处理，通过信号返回出去.
            return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
        };
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
}

// 2.2 ReactiveCocoa操作方法之映射(flattenMap,Map)
- (void)mapDemo
{
    // 2.2.1 flattenMap简单使用
    // 监听文本框的内容改变，把结构重新映射成一个新值.
    
    // flattenMap作用:把源信号的内容映射成一个新的信号，信号可以是任意类型。
    
    // flattenMap使用步骤:
    // 1.传入一个block，block类型是返回值RACStream，参数value
    // 2.参数value就是源信号的内容，拿到源信号的内容做处理
    // 3.包装成RACReturnSignal信号，返回出去。
    
    // flattenMap底层实现:
    // 0.flattenMap内部调用bind方法实现的,flattenMap中block的返回值，会作为bind中bindBlock的返回值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 2.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 3.调用bindBlock，内部就会调用flattenMap的block，flattenMap的block作用：就是把处理好的数据包装成信号。
    // 4.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 5.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
    
    [[_textField.rac_textSignal flattenMap:^RACStream *(id value) {
        // block什么时候 : 源信号发出的时候，就会调用这个block。
        // block作用 : 改变源信号的内容。
        // 返回值：绑定信号的内容.
        return [RACReturnSignal return:[NSString stringWithFormat:@"输出:%@",value]];
    }] subscribeNext:^(id x) {
        // 订阅绑定信号，每当源信号发送内容，做完处理，就会调用这个block。
        NSLog(@"%@",x);
    }];
    
    // 2.2.2 Map简单使用
    // 监听文本框的内容改变，把结构重新映射成一个新值.
    
    // Map作用:把源信号的值映射成一个新的值
    
    // Map使用步骤:
    // 1.传入一个block,类型是返回对象，参数是value
    // 2.value就是源信号的内容，直接拿到源信号的内容做处理
    // 3.把处理好的内容，直接返回就好了，不用包装成信号，返回的值，就是映射的值。
    
    // Map底层实现:
    // 0.Map底层其实是调用flatternMap,Map中block中的返回的值会作为flatternMap中block中的值。
    // 1.当订阅绑定信号，就会生成bindBlock。
    // 3.当源信号发送内容，就会调用bindBlock(value, *stop)
    // 4.调用bindBlock，内部就会调用flattenMap的block
    // 5.flattenMap的block内部会调用Map中的block，把Map中的block返回的内容包装成返回的信号。
    // 5.返回的信号最终会作为bindBlock中的返回信号，当做bindBlock的返回信号。
    // 6.订阅bindBlock的返回信号，就会拿到绑定信号的订阅者，把处理完成的信号内容发送出来。
    
    [[_textField.rac_textSignal map:^id(id value) {
        // 当源信号发出，就会调用这个block，修改源信号的内容
        // 返回值：就是处理完源信号的内容。
        return [NSString stringWithFormat:@"输出:%@",value];
    }] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    
    // 2.2.3
    /*
     FlatternMap和Map的区别
        1.FlatternMap中的Block返回信号。
        2.Map中的Block返回对象。
        3.开发中，如果信号发出的值不是信号，映射一般使用Map
        4.开发中，如果信号发出的值是信号，映射一般使用FlatternMap
     
    总结：signalOfsignals用FlatternMap。
     */
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
