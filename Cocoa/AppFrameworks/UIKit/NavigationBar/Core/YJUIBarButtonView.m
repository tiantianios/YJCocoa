//
//  YJUIBarButtonView.m
//  YJNavigationBar
//
//  HomePage:https://github.com/937447974/YJUIocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/6.
//  Copyright © 2016年 YJUIocoa. All rights reserved.
//

#import "YJUIBarButtonView.h"
#import "UIView+YJUIViewGeometry.h"

@implementation YJUIBarButtonView

#pragma mark - 共享
+ (instancetype)appearance {
    static YJUIBarButtonView *bbView;
    if (!bbView) {
        bbView = [[YJUIBarButtonView alloc] initWithAppearance];
    }
    return bbView;
}

- (instancetype)initWithAppearance {
    self = [super initWithFrame:CGRectZero];
    if (self) { // 默认共享
        self.titleColor = [UIColor blackColor];
        self.titleFont = [UIFont systemFontOfSize:14];
        self.highlightedAlpha = 0.5;
        self.spacing = 5;
    }
    return self;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        YJUIBarButtonView *bbView = [YJUIBarButtonView appearance];
        _titleColor = bbView.titleColor;
        _titleFont = bbView.titleFont;
        _highlightedAlpha = bbView.highlightedAlpha;
        _spacing = bbView.spacing;
    }
    return self;
}

#pragma mark setter & getter
- (void)setBarButtonItem:(YJUIBarButtonItem *)barButtonItem {
    _barButtonItem = barButtonItem;
    self.barButtonItems = @[barButtonItem];
}

- (void)setBarButtonItems:(NSArray<YJUIBarButtonItem *> *)barButtonItems {
    _barButtonItems = barButtonItems;
    NSMutableArray *barButtons = [NSMutableArray array];
    for (YJUIBarButtonItem *item in self.barButtonItems) {
        [barButtons addObject:[self buttonWithItem:item]];
    }
    self.barButtons = barButtons;
}

- (void)setBarButton:(UIButton *)barButton {
    _barButton = barButton;
    self.barButtons = @[barButton];
}

- (void)setBarButtons:(NSArray<UIButton *> *)barButtons {
    _barButtons = barButtons;
    // 界面渲染
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat x = -self.spacing;
    CGFloat y = (self.heightFrame - YJUIBarButtonHeight) / 2;
    for (UIButton *button in barButtons) {
        x += self.spacing;
        [self addSubview:button];
        button.topFrame = y;
        button.leadingFrame = x;
        x = button.trailingFrame;
    }
    self.widthFrame = x > 0 ? x : 0;
    // 回调
    if (self.reloadDataBlock) {
        self.reloadDataBlock(NO);
    }
}

#pragma mark - YJUIBarButtonItem转UIButton
- (UIButton *)buttonWithItem:(YJUIBarButtonItem *)item {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, YJUIBarButtonHeight)];
    [self addSubview:button];
    button.tag = item.tag;
    // 标题
    if (item.title) {
        button.titleLabel.font = self.titleFont;
        [button setTitle:item.title forState:UIControlStateNormal];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:[self.titleColor colorWithAlphaComponent:self.highlightedAlpha] forState:UIControlStateHighlighted];
    }
    // 图片
    if (item.image) {
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:[self imageWithAlpha:self.highlightedAlpha image:item.image] forState:UIControlStateHighlighted];
    }
    // 事件
    [button addTarget:item.target action:item.action forControlEvents:UIControlEventTouchUpInside];
    // 位置
    CGSize size = [button systemLayoutSizeFittingSize:CGSizeMake(300, 30)];
    if (size.width > 30) {
        button.widthFrame = size.width;
    }
    return button;
}

#pragma mark 图片透明度
- (UIImage *)imageWithAlpha:(CGFloat)alpha image:(UIImage*)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    CGContextSetAlpha(ctx, alpha);
    CGContextDrawImage(ctx, area, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
