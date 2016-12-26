//
//  NSObject+YJNSRouter.m
//  YJUINavigationRouter
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "NSObject+YJNSRouter.h"
#import <objc/runtime.h>

@interface NSObject (YJNSRouterDelegate) <YJNSRouterDelegate>
@end

@implementation NSObject (YJNSRouterDelegate)

- (instancetype)initWithRouterURL:(YJNSRouterURL)routerURL {
    return [self init];
}

- (BOOL)openCurrentRouter {
    return NO;
}

- (BOOL)receiveTargetRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options sender:(YJNSRouter *)sender {
    return NO;
}

@end


@implementation NSObject (YJNSRouter)

- (BOOL)openRouterURL:(YJNSRouterURL)routerURL options:(NSDictionary<YJNSRouterOptionsKey,id> *)options {
    Class targetRouterClass = [YJNSRouteManager.sharedManager routerClassForURL:routerURL];
    if (targetRouterClass) {
        NSObject *targetRouter = [[targetRouterClass alloc] initWithRouterURL:routerURL];
        YJNSRouter *router = [[self.router.class alloc] init];
        router.sourceRouter = self.router;
        router.sourceOptions = options;
        router.routerURL = routerURL;
        targetRouter.router = router;
        return [targetRouter openCurrentRouter];
    }
    return NO;
}

- (BOOL)sendSourceRouter:(YJNSRouterFoundationID)fID options:(NSDictionary<YJNSRouterOptionsKey,id> *)options {
    YJNSRouter *sourceRouter = self.router.sourceRouter;
    while (sourceRouter) {
        if ([sourceRouter.delegate receiveTargetRouter:fID options:options sender:self.router]) {
            return YES;
        }
        sourceRouter = sourceRouter.sourceRouter;
    }
    return NO;
}

#pragma mark getter & setter
- (YJNSRouter *)router {
    YJNSRouter *router = objc_getAssociatedObject(self, "YJNSRouter");
    if (!router) {
        router = [[YJNSRouter alloc] init];
        self.router = router;
    }
    return router;
}

- (void)setRouter:(YJNSRouter *)router {
    router.delegate = self;
    objc_setAssociatedObject(self, "YJNSRouter", router, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
