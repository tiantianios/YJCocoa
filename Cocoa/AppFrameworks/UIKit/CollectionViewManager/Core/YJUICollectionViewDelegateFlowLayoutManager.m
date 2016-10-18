//
//  YJUICollectionViewDelegateFlowLayoutManager.m
//  YJCollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 2016/10/18.
//  Copyright © 2016年 YJ. All rights reserved.
//

#import "YJUICollectionViewDelegateFlowLayoutManager.h"
#import "YJUICollectionViewManager.h"
#import "UIView+YJUIViewGeometry.h"

@interface YJUICollectionViewDelegateFlowLayoutManager () {
    NSMutableDictionary<NSString *, NSString*> *_cacheSizeDict; ///< 缓存Size
    UICollectionViewFlowLayout *_flowLayout;
}

@end

@implementation YJUICollectionViewDelegateFlowLayoutManager

- (instancetype)initWithManager:(YJUICollectionViewManager *)manager {
    self = [super initWithManager:manager];
    if (self) {
        _cacheSizeDict = [[NSMutableDictionary alloc] init];
        _isCacheSize = YES;
    }
    return self;
}

#pragma mark 清除所有缓存Size
- (void)clearAllCacheSize {
    [_cacheSizeDict removeAllObjects];
}

#pragma mark 获取cellObject对应的缓存key
- (NSString *)getKeyFromCellObject:(YJUICollectionCellObject *)cellObject {
    switch (self.cacheSizeStrategy) {
        case YJUICollectionViewCacheSizeDefault: // 根据相同的UITableViewCell类缓存高度
            return cellObject.cellName;
        case YJUICollectionViewCacheSizeIndexPath: // 根据NSIndexPath对应的位置缓存高度
            return [NSString stringWithFormat:@"%ld-%ld", cellObject.indexPath.section, cellObject.indexPath.item];
        case YJUICollectionViewCacheSizeClassAndIndexPath: // 根据类名和NSIndexPath双重绑定缓存高度
            return [NSString stringWithFormat:@"%@(%ld-%ld)", cellObject.cellName, cellObject.indexPath.section, cellObject.indexPath.item];
    }
}


#pragma mark - getter and setter
- (UICollectionViewFlowLayout *)flowLayout {
    _flowLayout = (UICollectionViewFlowLayout *)self.manager.collectionView.collectionViewLayout;
    if ([_flowLayout isKindOfClass:[UICollectionViewFlowLayout class]]) {
        return _flowLayout;
    }
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 获取YJUIableCellObject
    YJUICollectionCellObject *cellObject = self.manager.dataSourceGrouped[indexPath.section][indexPath.item];
    cellObject.indexPath = indexPath;
    // 存放缓存size的key
    NSString *key = [self getKeyFromCellObject:cellObject];
    CGSize size = self.flowLayout.itemSize;
    NSString *string;
    if (self.isCacheSize) {
        string = [_cacheSizeDict objectForKey:key];
    }
    if (!string) { //无缓存
        // 获取Size
        size = [cellObject.cellClass collectionViewManager:self.manager sizeForCellObject:cellObject];
    } else {
        size = CGSizeFromString(string);
    }
    if (self.lineItems) {
        CGFloat itemW = (collectionView.widthFrame - self.flowLayout.sectionInset.left - self.flowLayout.sectionInset.right - self.flowLayout.minimumInteritemSpacing * (self.lineItems - 1))/self.lineItems;
        if (self.itemHeightLayout) {
            size.height *= itemW / size.width;
        }
        size.width = itemW;
    }
    // 添加缓存
    if (self.isCacheSize) {
        [_cacheSizeDict setObject:NSStringFromCGSize(size) forKey:key];
    }
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionHeader referenceSizeForFooterInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return [self collectionView:collectionView viewForSupplementaryElementOfKind:UICollectionElementKindSectionFooter referenceSizeForFooterInSection:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForFooterInSection:(NSInteger)section {
    YJUICollectionCellObject *cellObject;
    NSMutableArray<YJUICollectionCellObject *> *dataSource;
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        dataSource = self.manager.dataSourceManager.headerDataSource;
    } else {
        dataSource = self.manager.dataSourceManager.footerDataSource;
    }
    CGSize size = CGSizeZero;
    if (dataSource.count == 0) {
        return size;
    }
    cellObject = dataSource[section];
    cellObject.indexPath = [NSIndexPath indexPathForItem:0 inSection:section];
    // 存放缓存size的key
    NSString *key = [NSString stringWithFormat:@"%@-%@", kind, [self getKeyFromCellObject:cellObject]];
    NSString *string;
    if (self.isCacheSize) {
        string = [_cacheSizeDict objectForKey:key];
    }
    if (!string) { //无缓存
        size = [cellObject.cellClass collectionViewManager:self.manager viewForSupplementaryElementOfKind:kind referenceSizeForCellObject:cellObject];
    } else {
        size = CGSizeFromString(string);
    }
    // 添加缓存
    if (self.isCacheSize) {
        [_cacheSizeDict setObject:NSStringFromCGSize(size) forKey:key];
    }
    return size;
}

@end
