//
//  TestObj.m
//  RuntimeTest
//
//  Created by ms on 2016/1/4.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import "TestObj.h"

@implementation TestObj
//- (void)encodeWithCoder:(NSCoder *)encoder
//{
//    //归档存储自定义对象
//    unsigned int count = 0;
//    //获得指向该类所有属性的指针
//    objc_property_t *properties =  class_copyPropertyList([self class], &count);
//    for (int i =0; i < count; i ++) {
//        //获得
//        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
//        const char *name = property_getName(property);
//        NSString *key = [NSString   stringWithUTF8String:name];
//        //      编码每个属性,利用kVC取出每个属性对应的数值
//        [encoder encodeObject:[self valueForKeyPath:key] forKey:key];
//    }}
//
//- (instancetype)initWithCoder:(NSCoder *)decoder
//{
//    //归档存储自定义对象
//    unsigned int count = 0;
//    //获得指向该类所有属性的指针
//    objc_property_t *properties = class_copyPropertyList([self class], &count);
//    for (int i =0; i < count; i ++) {
//        objc_property_t property = properties[i];        //根据objc_property_t获得其属性的名称--->C语言的字符串
//        const char *name = property_getName(property);
//        NSString *key = [NSString stringWithUTF8String:name];        //解码每个属性,利用kVC取出每个属性对应的数值
//        [self setValue:[decoder decodeObjectForKey:key] forKeyPath:key];
//    }
//    return self;
//}

@end
