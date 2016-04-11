//
//  ISNTableDataSource.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/23.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNTableDataSource.h"

@interface ISNTableDataSource ()

@property (nonatomic, strong) NSArray *items;
// 用copy(深拷贝，对象完全复制，不是浅拷贝只拷贝指针地址)是防止cellIdentifier半路变掉了
@property (nonatomic, copy) NSString *cellIdentifier;
// copy block到堆上，防止声明在栈上或者global的block已经析构掉了
@property (nonatomic, copy) TableViewCellConfigureBlock configureBlock;

@end

@implementation ISNTableDataSource
// 如果使用[ISNTableDataSource new]只能得到nil，防止new后无法正常提供DataSource
- (instancetype)init {
    return nil;
}

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    self = [super init];
    if (self) {
        self.items = anItems;
        self.cellIdentifier = aCellIdentifier;
        self.configureBlock = [aConfigureCellBlock copy];
    }
    return self;
}

/**
 *  根据indexPath返回需要的数据，这里可以重写或者重载
 *
 *  @param indexPath tableview的indexPath
 *
 *  @return 返回具体的indexPath数据
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath {
    return self.items[indexPath.row];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];

    id item = [self itemAtIndexPath:indexPath];
    self.configureBlock(cell, item);
    return cell;
}


@end
