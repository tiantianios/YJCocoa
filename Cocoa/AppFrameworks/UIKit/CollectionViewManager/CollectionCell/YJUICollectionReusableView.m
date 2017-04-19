//
//  YJUICollectionReusableView.m
//  YJUICollectionView
//
//  HomePage:https://github.com/937447974/YJCocoa
//  YJ技术支持群:557445088
//
//  Created by 阳君 on 16/7/8.
//  Copyright © 2016年 YJCocoa. All rights reserved.
//

#import "YJUICollectionReusableView.h"
#import "YJUICollectionViewManager.h"
#import "YJDispatch.h"
#import "YJNSFoundationOther.h"

#pragma mark - UICollectionReusableView (YJUICollectionView)
@implementation UICollectionReusableView (YJUICollectionView)

#pragma mark (+)
+ (YJUICollectionCellCreate)cellCreate {
    [self doesNotRecognizeSelector:_cmd];
    return YJUICollectionCellCreateClass;
}

+ (YJUICollectionCellObject *)cellObject {
    YJUICollectionCellObject *cellObject = [[YJUICollectionCellObject alloc] initWithCollectionViewCellClass:self.class];
    cellObject.createCell = self.cellCreate;
    return cellObject;
}

+ (YJUICollectionCellObject *)cellObjectWithCellModel:(id<YJUICollectionCellModel>)cellModel {
    YJUICollectionCellObject *cellObject = self.cellObject;
    cellObject.cellModel = cellModel;
    return cellObject;
}

+ (CGSize)collectionViewManager:(YJUICollectionViewManager *)collectionViewManager viewForSupplementaryElementOfKind:(NSString *)kind referenceSizeForCellObject:(YJUICollectionCellObject *)cellObject {
    if (cellObject.createCell == YJUICollectionCellCreateClass) { // 默认使用xib创建cell
        NSArray<UIView *> *array = [[NSBundle mainBundle] loadNibNamed:cellObject.cellName owner:nil options:nil];
        return array.firstObject.frame.size;
    }
    // 默认设置
    if ([UICollectionElementKindSectionHeader isEqualToString:kind]) {
        return collectionViewManager.delegateFlowLayoutManager.flowLayout.headerReferenceSize;
    }
    return collectionViewManager.delegateFlowLayoutManager.flowLayout.footerReferenceSize;
}

#pragma mark (-)
- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    [self doesNotRecognizeSelector:_cmd];
}

@end

#pragma mark YJUICollectionViewCell
@implementation YJUICollectionReusableView

#pragma mark - getter & setter
- (NSString *)reuseIdentifier {
    NSString *reuseIdentifier = [super reuseIdentifier];
    if (reuseIdentifier) return reuseIdentifier;
    return YJNSStringFromClass(self.class);
}

#pragma mark -
+ (YJUICollectionCellCreate)cellCreate {
    if ([YJNSStringFromClass([YJUICollectionReusableView class]) isEqualToString:YJNSStringFromClass(self.class)]) {
        return YJUICollectionCellCreateClass;
    }
    return [super cellCreate];
}

- (void)reloadDataWithCellObject:(YJUICollectionCellObject *)cellObject collectionViewManager:(YJUICollectionViewManager *)collectionViewManager {
    _cellObject = cellObject;
    _collectionViewManager = collectionViewManager;
}

@end
