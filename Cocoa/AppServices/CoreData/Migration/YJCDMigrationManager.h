//
//  YJCDMigrationManager.h
//  YJCoreData
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/27.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

/** 迁移管理器*/
@interface YJCDMigrationManager : NSObject

@property (nonatomic, copy) void (^ migrationProgress)(float progress); ///< 迁移进度[0,1]

@property (nonatomic, strong, nullable) NSError *migrateError; ///< 迁移失败时的错误信息

/**
 *  @abstract 执行迁移升级数据库操作
 *  @discusstion 会堵塞线程，建议后台执行
 *
 *  @return BOOL
 */
- (BOOL)migrateStore;

@end

NS_ASSUME_NONNULL_END
