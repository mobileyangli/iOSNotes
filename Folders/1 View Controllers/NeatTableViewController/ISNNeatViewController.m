//
//  ISNNeatViewController.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/24.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNNeatTableViewController.h"
#import "ISNNeatViewController.h"

@interface ISNNeatViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bannerImageView;
@property (nonatomic, strong) ISNNeatTableViewController *tableViewController;

@end

@implementation ISNNeatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.tableViewController = [ISNNeatTableViewController new];

    // tableview controller 中可以使用parentcontroller来访问它的持有者
    [self addChildViewController:self.tableViewController];

    // 布局需要坐标信息，获取参照view的bounds要比frame准确，因为frame是相对父坐标的位置rect
    CGRect frame = CGRectInset(self.view.bounds, 0, self.bannerImageView.frame.size.height / 2);
    frame.origin.y = self.bannerImageView.frame.size.height;
    self.tableViewController.tableView.frame = frame;
    [self.view addSubview:self.tableViewController.tableView];
}

@end
