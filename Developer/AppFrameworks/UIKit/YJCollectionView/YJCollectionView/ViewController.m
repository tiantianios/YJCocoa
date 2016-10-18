//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJTestCollectionViewCell.h"
#import "YJDispatch.h"
#import "YJTestCollectionReusableView.h"

@interface ViewController () <YJUICollectionViewManagerDelegate, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YJUICollectionViewManager *collectionViewManager; ///< 数据源管理

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionViewManager = [[YJUICollectionViewManager alloc] initWithCollectionView:self.collectionView];
    // 设置相关属性
    self.collectionViewManager.delegateFlowLayoutManager.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.collectionViewManager.delegateFlowLayoutManager.flowLayout.minimumLineSpacing = 5;
    self.collectionViewManager.delegateFlowLayoutManager.flowLayout.minimumInteritemSpacing = 5;
    self.collectionViewManager.delegateFlowLayoutManager.lineItems = 3;          // 一行显示个数
    self.collectionViewManager.delegateFlowLayoutManager.itemHeightLayout = YES; // 是否自动适配高
    self.collectionViewManager.delegate = self;
    // AOP代理
    [self.collectionViewManager addCollectionViewAOPDelegate:self];
    // 测试数据
    for (int i = 0; i<20; i++) {
        YJTestCollectionCellModel *cellModel = [[YJTestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.collectionViewManager.dataSource addObject:[YJTestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    // 头部、尾部
    YJTestCollectionReusableViewModel *hvm = [[YJTestCollectionReusableViewModel alloc] init];
    hvm.backgroundColor = [UIColor greenColor];
    [self.collectionViewManager.dataSourceManager.headerDataSource addObject:[YJTestCollectionReusableView cellObjectWithCellModel:hvm]];
    YJTestCollectionReusableViewModel *fvm = [[YJTestCollectionReusableViewModel alloc] init];
    fvm.backgroundColor = [UIColor redColor];
    YJUICollectionCellObject *co = [YJTestCollectionReusableView cellObjectWithCellModel:fvm];
    co.createCell = YJUICollectionCellCreateClass;
    [self.collectionViewManager.dataSourceManager.footerDataSource addObject:co];
}

#pragma mark - YJCollectionViewCellProtocol
- (void)collectionCell:(UICollectionViewCell *)cell sendWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

#pragma mark YJUICollectionViewManagerDelegate
- (void)collectionViewManager:(YJUICollectionViewManager *)manager didSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)collectionViewManagerloadingPageData:(YJUICollectionViewManager *)manager {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)collectionViewManager:(YJUICollectionViewManager *)manager scroll:(YJUICollectionViewScroll)scroll {
    NSLog(@"%@ -- %lu", NSStringFromSelector(_cmd), scroll);
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@--%@", NSStringFromSelector(_cmd), indexPath);
}


@end
