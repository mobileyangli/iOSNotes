//
//  ISNContainerViewController.h
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/19.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import <UIKit/UIKit.h>
// 其他地方有ContainerViewControllerDelegate的定义，这里先告诉编译器一下。
@protocol ContainerViewControllerDelegate;

@interface ISNContainerViewController : UIViewController

@property (nonatomic, assign) id<ContainerViewControllerDelegate>delegate;
@property (nonatomic, readonly) NSArray *viewControllers;
@property (nonatomic, assign) UIViewController *selectedViewController;

- (instancetype)initWithViewControllers:(NSArray *)aViewControllers;

@end


@protocol ContainerViewControllerDelegate <NSObject>

@optional
- (void)containerViewController:(ISNContainerViewController *)containerViewController didSelectViewController:(UIViewController *)viewController;
- (id<UIViewControllerAnimatedTransitioning>)containerViewController:(ISNContainerViewController *)containerViewController animationControllerForTransitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController;
@end