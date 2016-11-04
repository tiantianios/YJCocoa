//
//  YJPerformSelectorTest.m
//  YJFoundation
//
//  Created by 阳君 on 2016/10/10.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YJFoundation.h"

@interface YJPerformSelectorTest : XCTestCase

@end

@implementation YJPerformSelectorTest

- (void)testExample {
    [self performSelector:@selector(testPerformSelector1) withObjects:nil];
    [self performSelector:@selector(testPerformSelector2:withObject:withObject:) withObjects:@[@"1",@"2"]];
    YJNSPerformSelector *result = [self performSelector:@selector(testPerformSelector3:withObject:) withObjects:@[@"1",@"2"]];
    NSLog(@"%d---%@", result.success, result.result);
    // 多参数，方法不接受
    // 方法传入多参数
    [self performSelector:@selector(testPerformSelector1) withObjects:@[@"1",@"2"]];
}

- (void)testPerformSelector1 {
    NSLog(NSStringFromSelector(_cmd), nil);
}

- (void)testPerformSelector2:(id)object0 withObject:(id)object1 withObject:(id)object2 {
    NSLog(NSStringFromSelector(_cmd), nil);
    NSLog(@"0:%@; 1:%@; 2:%@", object0, object1, object2);
}

- (NSString *)testPerformSelector3:(id)object1 withObject:(id)object2 {
    NSLog(NSStringFromSelector(_cmd), nil);
    NSLog(@"0:%@; 1:%@; ", object1, object2);
    return @"阳君";
}

@end
