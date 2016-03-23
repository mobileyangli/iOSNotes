//
//  ISNTableDataSource.h
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/23.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  具体配置cell内容的block
 *
 *  @param cell tablecell类型或子类
 *  @param item 某个cell对应的数据
 */
typedef void (^TableViewCellConfigureBlock)(id cell, id item);


@interface ISNTableDataSource : NSObject <UITableViewDataSource>

- (instancetype)initWithItems:(NSArray *)anItems cellIdentifier:(NSString *)aCellIdentifier configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;
/**
 *  tableview controller经常会用到indexPath上的数据，此函数为publish
 *
 *  @param indexPath tableview的indexPath
 *
 *  @return 具体indexPath上的数据
 */
- (id)itemAtIndexPath:(NSIndexPath *)indexPath;
@end
