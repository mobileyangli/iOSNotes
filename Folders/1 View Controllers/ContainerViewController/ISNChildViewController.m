//
//  ISNChildViewController.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/19.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNChildViewController.h"

static NSInteger const kTag_LabelTitle = 100;

@interface ISNChildViewController ()

@end

@implementation ISNChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    UILabel *labelTitle = [self.view viewWithTag:kTag_LabelTitle];
    labelTitle.text = self.title;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
