//
//  ISNContainerViewController.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/19.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNContainerTransition.h"
#import "ISNContainerViewController.h"

static CGFloat const kButtonSlotWidth = 64; // Also distance between button centers
static CGFloat const kButtonSlotHeight = 44;

#pragma mark - Private Transition Class
@interface PrivateTransitionContext : NSObject <UIViewControllerContextTransitioning>
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight;
@property (nonatomic, copy) void (^completeBlock)(BOOL didComplete);
@property (nonatomic, assign, getter=isAnimated) BOOL animated;
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;
@end

@interface PrivateTransitionContext ()
@property (nonatomic, strong) NSDictionary *privateViewControllers;
// 第二阶段是缩小和淡出fromView，不需要的属性，先注释掉
//@property (nonatomic, assign) CGRect privateDisappearingFromRect;
//@property (nonatomic, assign) CGRect privateAppearingFromRect;
//@property (nonatomic, assign) CGRect privateDisappearingToRect;
//@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak) UIView *containerView;
//@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@end

@implementation PrivateTransitionContext
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController goingRight:(BOOL)goingRight {
    NSAssert([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");

    if (self = [super init]) {
        //        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{
            UITransitionContextFromViewControllerKey : fromViewController,
            UITransitionContextToViewControllerKey : toViewController
        };

        //        CGFloat travelDistance = (goingRight ? -1 : 1) * self.containerView.bounds.size.width;
        //        self.privateDisappearingFromRect = self.privateAppearingToRect = self.containerView.bounds;
        //        self.privateDisappearingToRect = CGRectOffset(self.containerView.bounds, travelDistance, 0);
        //        self.privateAppearingFromRect = CGRectOffset(self.containerView.bounds, -travelDistance, 0);
    }

    return self;
}
- (UIViewController *)viewControllerForKey:(NSString *)key {
    return self.privateViewControllers[key];
}
- (BOOL)transitionWasCancelled {
    // 没有交互效果，不需要cancel
    return NO;
}
- (void)completeTransition:(BOOL)didComplete {
    if (self.completeBlock) {
        self.completeBlock(didComplete);
    }
}
@end


@interface ISNContainerViewController ()
@property (nonatomic, readwrite) NSArray *viewControllers;
@property (nonatomic, strong) UIView *privateButtonsView;
@property (nonatomic, strong) UIView *privateContainerView;
@property (nonatomic, strong) ISNContainerTransition *animator;
@end

@implementation ISNContainerViewController
- (instancetype)initWithViewControllers:(NSArray *)aViewControllers {
    NSParameterAssert([aViewControllers count] > 0);
    self = [super init];
    if (self) {
        self.viewControllers = aViewControllers;
    }
    return self;
}
- (void)loadView {
    UIView *rootView = [UIView new];
    rootView.backgroundColor = [UIColor blackColor];
    rootView.opaque = YES;

    self.privateContainerView = [[UIView alloc] init];
    self.privateContainerView.backgroundColor = [UIColor blackColor];
    self.privateContainerView.opaque = YES;

    self.privateButtonsView = [[UIView alloc] init];
    self.privateButtonsView.backgroundColor = [UIColor clearColor];
    // 将作用于加入其中的button image渲染模式上导致button的颜色如下
    self.privateButtonsView.tintColor = [UIColor colorWithWhite:1 alpha:0.75f];

    [self.privateContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.privateButtonsView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [rootView addSubview:self.privateContainerView];
    [rootView addSubview:self.privateButtonsView];

    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateContainerView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:rootView attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:[self.viewControllers count] * kButtonSlotWidth]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:kButtonSlotHeight]];
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.privateButtonsView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.privateContainerView attribute:NSLayoutAttributeCenterY multiplier:0.4f constant:0]];

    [self _addChildViewControllerButtons];

    self.view = rootView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedViewController = (self.selectedViewController ?: self.viewControllers[0]);
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.selectedViewController;
}
- (void)setSelectedViewController:(UIViewController *)aSelectedViewController {
    NSParameterAssert(aSelectedViewController);
    [self _transitionToChildViewController:aSelectedViewController];
    _selectedViewController = aSelectedViewController;
    [self _updateButtonSelection];
}

#pragma mark - private method
- (void)_addChildViewControllerButtons {
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *_Nonnull childViewController, NSUInteger idx, BOOL *_Nonnull stop) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *icon = [childViewController.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:icon forState:UIControlStateNormal];
        UIImage *selectedIcon = [childViewController.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [button setImage:selectedIcon forState:UIControlStateSelected];

        button.tag = idx;
        [button addTarget:self action:@selector(_buttonTapped:) forControlEvents:UIControlEventTouchUpInside];

        [self.privateButtonsView addSubview:button];
        [button setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeLeading multiplier:1 constant:(idx + 0.5f) * kButtonSlotWidth]];
        [self.privateButtonsView addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.privateButtonsView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    }];
}
- (void)_buttonTapped:(UIButton *)button {
    UIViewController *selectedViewController = self.viewControllers[button.tag];
    self.selectedViewController = selectedViewController;
}
- (void)_updateButtonSelection {
    [self.privateButtonsView.subviews enumerateObjectsUsingBlock:^(__kindof UIButton *_Nonnull button, NSUInteger idx, BOOL *_Nonnull stop) {
        button.selected = (self.viewControllers[idx] == self.selectedViewController);
    }];
}
- (void)_transitionToChildViewController:(UIViewController *)toViewController {
    UIViewController *fromViewController = (self.childViewControllers.count > 0 ? self.childViewControllers[0] : nil);
    if (toViewController == fromViewController || ![self isViewLoaded]) {
        return;
    }

    UIView *toView = toViewController.view;
    // 子view的自适应大小
    [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
    toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    toView.frame = self.privateContainerView.bounds;

    // fromViewControll将从parent view controll中删除，必须显示调用 willMoveToParentViewController:nil
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];

    // begin: 第一阶段没有动画
    //    [self.privateContainerView addSubview:toView];
    //    [fromViewController.view removeFromSuperview];
    //    [fromViewController removeFromParentViewController];
    //    // toViewController将不会自动调用didMoveToParentViewController:self，需要显示调用
    //    [toViewController didMoveToParentViewController:self];
    // end:

    // 第一次加入，还没有fromViewController
    if (!fromViewController) {
        [self.privateContainerView addSubview:toView];
        [toViewController didMoveToParentViewController:self];
        return;
    }

    // 1、创建animator
    self.animator = [ISNContainerTransition new];
    // 2、创建转场上下文
    // private animation transition context,将记录转换的view controllers，和转换方向等细节信息，animtor将使用该上下文信息。
    NSUInteger fromIndex = [self.viewControllers indexOfObject:fromViewController];
    NSUInteger toIndex = [self.viewControllers indexOfObject:toViewController];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:fromViewController toViewController:toViewController goingRight:toIndex > fromIndex];

    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completeBlock = ^(BOOL didComplete) {
        [fromViewController.view removeFromSuperview];
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];

        if ([self.animator respondsToSelector:@selector(animationEnded:)]) {
            [self.animator animationEnded:didComplete];
        }
        self.privateButtonsView.userInteractionEnabled = YES;
    };

    // 3、触发动画执行
    self.privateButtonsView.userInteractionEnabled = NO;
    [_animator animateTransition:transitionContext];
}
@end
