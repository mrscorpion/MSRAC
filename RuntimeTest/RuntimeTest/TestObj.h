//
//  TestObj.h
//  RuntimeTest
//
//  Created by ms on 2016/1/4.
//  Copyright © 2017年 mrscorpion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface TestObj : NSObject<NSCoding>
{
    NSString *name; // 成员变量
}
@property (nonatomic, strong) NSString *str;
@property (nonatomic, assign) NSInteger num;

- (void)run;
@end
