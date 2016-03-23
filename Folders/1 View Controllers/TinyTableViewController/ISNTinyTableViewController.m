//
//  ISNTinyTableViewController.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/23.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNTableDataSource.h"
#import "ISNTinyTableViewController.h"

@interface ISNTinyTableViewController ()
@property (nonatomic, strong) ISNTableDataSource *arrayDataSource;
@property (nonatomic, strong) NSArray *items;
@end

@implementation ISNTinyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupItems];
    [self setupTableView];
}
- (void)setupItems {
    // 获取model类的数据内容
    self.items = @[ @"aaa", @"bbb" ];
}
- (void)setupTableView {
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    void (^configureCell)(UITableViewCell *, NSString *) = ^(UITableViewCell *cell, NSString *title) {
        cell.textLabel.text = title;
    };
    self.arrayDataSource = [[ISNTableDataSource alloc] initWithItems:self.items cellIdentifier:@"Cell" configureCellBlock:configureCell];
    self.tableView.dataSource = self.arrayDataSource;
}
@end
