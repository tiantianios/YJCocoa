//
//  YJSecondViewController.m
//  YJTableViewFactory
//
//  Created by 阳君 on 16/3/26.
//  Copyright © 2016年 YJFactory. All rights reserved.
//

#import "YJSecondViewController.h"
#import "YJTestTableViewCell.h"

@interface YJSecondViewController () <UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 需要强引用
@property (nonatomic, strong) YJTableViewDataSource *dataSourceGrouped;

@end

@implementation YJSecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.dataSourceGrouped = [[YJTableViewDataSource alloc] initWithTableView:self.tableView];
    self.tableView.delegate = self;
    // 测试数据
    for (int i=0; i<3; i++) {
        NSMutableArray *array = [NSMutableArray arrayWithCapacity:20];
        for (int j=0; j<20; j++) {
            // 封装模型
            YJTestTableCellModel *cellModel = [[YJTestTableCellModel alloc] init];
            cellModel.userName = [NSString stringWithFormat:@"阳君-%d", j];
            // 封装CellObject
            YJTestTableCellObject *cellObject = [[YJTestTableCellObject alloc] init];
            cellObject.cellModel = cellModel;
            // 填充数据源
            [array addObject:cellObject];
        }
        [self.dataSourceGrouped.dataSourceGrouped addObject:array];
    }
    
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceGrouped.tableViewDelegate tableView:tableView heightForRowAtIndexPath:indexPath];    
}

@end
