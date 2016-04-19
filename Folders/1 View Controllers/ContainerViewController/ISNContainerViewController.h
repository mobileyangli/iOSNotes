//
//  ISNContainerViewController.h
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/19.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISNContainerViewController : UIViewController

@property (nonatomic, readonly) NSArray *viewControllers;
@property (nonatomic, assign) UIViewController *selectedViewController;

- (instancetype)initWithViewControllers:(NSArray *)aViewControllers;

@end
