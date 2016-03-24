//
//  ISNNeatTableViewController.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/24.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNNeatTableViewController.h"
#import "ISNTableDataSource.h"

@interface ISNNeatTableViewController ()
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) ISNTableDataSource *dataSource;
@end

@implementation ISNNeatTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupItems];
    [self setupTableView];
}
- (void)setupItems {
    self.items = [NSMutableArray new];
    for (int i = 0; i < 20; i++) {
        [self.items addObject:[NSString stringWithFormat:@"array[%d]", i]];
    }
}
- (void)setupTableView {
    NSString *cellIdentifier = @"Cell";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellIdentifier];

    void (^configureCell)(UITableViewCell *, NSString *) = ^(UITableViewCell *cell, NSString *item) {
        cell.textLabel.text = item;
    };

    self.dataSource = [[ISNTableDataSource alloc] initWithItems:self.items cellIdentifier:cellIdentifier configureCellBlock:configureCell];
    self.tableView.dataSource = self.dataSource;
}

@end
