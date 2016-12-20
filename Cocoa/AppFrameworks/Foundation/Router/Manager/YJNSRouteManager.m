//
//  YJNSRouteManager.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJNSRouteManager.h"
#import "YJNSSingletonMCenter.h"

@interface YJNSRouteManager ()

@property (nonatomic, strong) NSMutableDictionary<YJNSRouterURL, Class> *routerPool; ///< 路由器池

@end

@implementation YJNSRouteManager

+ (YJNSRouteManager *)sharedManager {
    return [YJNSSingletonMC registerStrongSingleton:[self class]];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.routerPool = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - routerPool
- (void)registerRouter:(Class)routerClass forURL:(YJNSRouterURL)routerURL {
    [self.routerPool setObject:routerClass forKey:routerURL];
}

- (Class)routerClassForURL:(YJNSRouterURL)routerURL {
    return [self.routerPool objectForKey:routerURL];
}

@end
