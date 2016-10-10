//
//  ViewController.m
//  YJCollectionView
//
//  Created by 阳君 on 16/5/16.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "ViewController.h"
#import "YJUICollectionView.h"
#import "YJUIestCollectionViewCell.h"
#import "YJCSystem.h"
#import "YJUIestCollectionReusableView.h"

@interface ViewController () <YJUICollectionViewCellProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YJUICollectionViewDataSource *dataSoutce; ///< 数据源管理

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSoutce = [[YJUICollectionViewDataSource alloc] initWithCollectionView:self.collectionView];
    // 设置相关属性
    self.dataSoutce.flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.dataSoutce.flowLayout.minimumLineSpacing = 5;
    self.dataSoutce.flowLayout.minimumInteritemSpacing = 5;
    self.dataSoutce.delegate.lineItems = 3;          // 一行显示个数
    self.dataSoutce.delegate.itemHeightLayout = YES; // 是否自动适配高
    self.dataSoutce.delegate.cellDelegate = self;
    // 测试数据
    for (int i = 0; i<20; i++) {
        YJUIestCollectionCellModel *cellModel = [[YJUIestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.dataSoutce.dataSource addObject:[YJUIestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    // 头部、尾部
    YJUIestCollectionReusableViewModel *hvm = [[YJUIestCollectionReusableViewModel alloc] init];
    hvm.backgroundColor = [UIColor greenColor];
    [self.dataSoutce.headerDataSource addObject:[YJUIestCollectionReusableView cellObjectWithCellModel:hvm]];
    YJUIestCollectionReusableViewModel *fvm = [[YJUIestCollectionReusableViewModel alloc] init];
    fvm.backgroundColor = [UIColor redColor];
    YJUICollectionCellObject *co = [YJUIestCollectionReusableView cellObjectWithCellModel:fvm];
    co.createCell = YJUICollectionCellCreateClass;
    [self.dataSoutce.footerDataSource addObject:co];
}

#pragma mark - YJCollectionViewCellProtocol
- (void)collectionViewDidSelectCellWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewCell:(nullable UICollectionViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self.collectionView reloadData];
}

- (void)collectionViewLoadingPageData:(YJUICollectionCellObject *)cellObject willDisplayCell:(UICollectionViewCell *)cell {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSLog(@"%@", self.dataSoutce.collectionHeaderView);
    NSLog(@"%@", self.dataSoutce.collectionFooterView);
    return;
    for (int i = 0; i<10; i++) {
        YJUIestCollectionCellModel *cellModel = [[YJUIestCollectionCellModel alloc] init];
        cellModel.index = [NSString stringWithFormat:@"%d", i];
        [self.dataSoutce.dataSource addObject:[YJUIestCollectionViewCell cellObjectWithCellModel:cellModel]];
    }
    dispatch_async_main(^{
        [self.collectionView reloadData];
    });
}

- (void)collectionView:(UICollectionView *)collectionView scroll:(YJUICollectionViewScroll)scroll {
    NSLog(@"%lu", scroll);
}


@end
