//
//  ISNContainerTransition.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/4/20.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "ISNContainerTransition.h"

@implementation ISNContainerTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1.f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromViewController=[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController*toViewController=[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
}

@end
