//
//  UIViewController+YJUINavigationRouter.m
//  YJUINavigationRouter
//
//  Created by 阳君 on 2016/12/20.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "UIViewController+YJUINavigationRouter.h"

@implementation UIViewController (YJUINavigationRouter)

- (BOOL)openTargetRouter {
    if ([self.router.sourceRouter.currentController isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = self.router.sourceRouter.currentController;
        if (vc.navigationController) {
            [vc.navigationController pushViewController:self animated:YES];
            return YES;
        }
    }
    return [super openTargetRouter];
}

@end
