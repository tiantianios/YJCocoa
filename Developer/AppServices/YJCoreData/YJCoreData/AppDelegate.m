//
//  AppDelegate.m
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "AppDelegate.h"
#import "YJCoreData.h"

#import "YJNSDirectory.h"
#import "YJDispatch.h"

#define version 2
#define version1 version==1
#define version2 version==2

#if version1
#import "YJTest+CoreDataClass.h"
#elif version2
#import "YJUser+CoreDataClass.h"
#import "YJPhone+CoreDataClass.h"
#endif

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self testMigration];
    return YES;
}

#pragma mark 迁移数据
- (void)testMigration {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    NSLog(@"%@", storeURL);
    __block NSError *error;
#if version1
    [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
#endif
    YJCDMSetup setup = [YJCDManagerS setupWithStoreURL:storeURL error:&error];
    // MigrationModel version1 -> 2
    if (setup == YJCDMSetupSuccess) { // 添加测试数据
#if version1
        for (int i = 0; i < 200000; i++) {
            YJTest *test = [YJTest insertNewObject];
            test.names = [NSString stringWithFormat:@"阳君-%d", i];
        }
        [YJCDManagerS saveInStore:^(BOOL success, NSError * _Nonnull error) {
            success ? abort() : NSLog(@"%@", error);
        }];
#endif
    } else if (setup == YJCDMSetupMigration) {
        dispatch_async_background(^{
            YJCDMigrationManager *mm = [[YJCDMigrationManager alloc] init];
            NSLog(@"数据库升级是否成功：%d", [mm migrateStore:&error]);
            if (error) {
                NSLog(@"升级错误：%@", error);
            } else {
                
            }
        });
    } else {
        NSLog(@"%@", error);
    }
}

#pragma mark 导入数据
- (void)testImport {
    NSURL *storeURL = [YJNSDirectoryS.documentURL URLByAppendingPathComponent:@"YJCoreData/CoreData.sqlite"];
    [YJCDManagerS setupWithStoreURL:storeURL error:nil];
}

@end
