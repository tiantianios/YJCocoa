//
//  YJUIImagePageViewController.m
//  YJUIPageView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/5/7.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUIImagePageViewController.h"

@interface YJUIImagePageViewController ()

@end

@implementation YJUIImagePageViewController

#pragma mark - IBAction 点击图片
- (IBAction)onClickImageView:(id)sender {
    self.pageView.pageViewDidSelect(self);
}

#pragma mark - YJUIPageView
- (void)reloadDataWithPageViewCellObject:(YJUIPageViewCellObject *)cellObject pageView:(YJUIPageView *)pageView {
    [super reloadDataWithPageViewCellObject:cellObject pageView:pageView];
    YJUIImagePageModel *model = cellObject.cellModel;
    self.imageView.image = [UIImage imageNamed:model.imageNamed];
    self.imageView.userInteractionEnabled = model.isOnClick;
}

@end
