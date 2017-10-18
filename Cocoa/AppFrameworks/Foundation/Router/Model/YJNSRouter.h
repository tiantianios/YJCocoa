//
//  YJNSRouter.h
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YJNSRouterDelegate.h"
#import "YJNSRouterNode.h"

NS_ASSUME_NONNULL_BEGIN

/** 路由导航实体*/
@interface YJNSRouter : NSObject

@property (nonatomic, weak)   YJNSRouter *sourceRouter;                              ///< 来源路由
@property (nonatomic, strong) NSDictionary<YJNSRouterOptionsKey, id> *sourceOptions; ///< 来源配置

@property (nonatomic, weak) id<YJNSRouterDelegate> delegate; ///< 当前控制器，默认VC
@property (nonatomic, strong) YJNSRouterNode *routerNode;    ///< 当前控制器对应的路由节点

/**
 *  @abstract 初始化
 *
 *  @param sourceRouter  来源路由
 *  @param sourceOptions 来源配置
 *  @param delegate      当前控制器，默认VC
 *  @param routerNode    当前控制器对应的路由节点
 *
 *  @return instancetype
 */
- (instancetype)initWithSourceRouter:(nullable YJNSRouter *)sourceRouter sourceOptions:(nullable NSDictionary<YJNSRouterOptionsKey, id> *)sourceOptions delegate:(id<YJNSRouterDelegate>)delegate routerNode:(YJNSRouterNode *)routerNode;

@end

NS_ASSUME_NONNULL_END
