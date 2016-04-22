//
//  UIViewController+WXSSwizzing.m
//  WXSRuntime
//
//  Created by 王小树 on 16/4/20.
//  Copyright © 2016年 王小树. All rights reserved.
//

#import "UIViewController+WXSSwizzing.h"


@implementation UIViewController (WXSSwizzing)
+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Method m1 = class_getClassMethod([self class], @selector(count));
        Method m2 = class_getClassMethod([self class], @selector(wxscount));
        
        BOOL isSuccess = class_addMethod([self class], @selector(count), method_getImplementation(m2), method_getTypeEncoding(m2));
        if (isSuccess) {
            // 添加成功：将源方法的实现替换到交换方法的实现
            // count方法实现被m2实现替换
            class_replaceMethod([self class], @selector(wxscount), method_getImplementation(m2), method_getTypeEncoding(m2));
        }else {
            //添加失败：说明源方法已经有实现，直接将两个方法的实现交换即
            method_exchangeImplementations(m1, m2);
        }
    });
}
-(void)wxscount {
    NSLog(@"变成了wxsCount");
}
-(void)count {
    NSLog(@"count");
}

+(void)forTest{
    UIViewController *vc = [[UIViewController alloc] init];
    [vc count];
}
@end
