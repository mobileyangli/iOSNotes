//
//  AppDelegate.m
//  iOSNotes
//
//  Created by 杨冬凌 on 16/3/23.
//  Copyright © 2016年 yangdongling. All rights reserved.
//

#import "AppDelegate.h"
#import "ISNChildViewController.h"
#import "ISNContainerViewController.h"
#import "ISNTinyTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self initRootViewControllerWithContainerViewController];

    return YES;
}

- (NSArray *)getRootViewControllerWithContainerViewController {
    static NSString *const kTitle = @"title";
    static NSString *const kColor = @"color";
    NSArray *configArray = @[ @{ kTitle : @"First",
                                 kColor : [UIColor redColor] },
                              @{ kTitle : @"Second",
                                 kColor : [UIColor orangeColor] },
                              @{ kTitle : @"Third",
                                 kColor : [UIColor purpleColor] } ];
    NSMutableArray *controllers = [NSMutableArray new];
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"ISNContainerView" bundle:nil];
    [configArray enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL *_Nonnull stop) {
        NSDictionary *dict = obj;
        ISNChildViewController *controller = [storyBoard instantiateViewControllerWithIdentifier:@"ISNChildViewController"];
        controller.title = dict[kTitle];
        controller.view.backgroundColor = dict[kColor];
        controller.tabBarItem.image = [UIImage imageNamed:dict[kTitle]];
        controller.tabBarItem.selectedImage = [UIImage imageNamed:[dict[kTitle] stringByAppendingString:@" Selected"]];

        [controllers addObject:controller];
    }];

    return [NSArray arrayWithArray:controllers];
}
- (void)initRootViewControllerWithContainerViewController {
    NSArray *viewControllers = [self getRootViewControllerWithContainerViewController];

    ISNContainerViewController *containerController = [[ISNContainerViewController alloc] initWithViewControllers:viewControllers];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:containerController];
    [self.window makeKeyWindow];
}

- (void)initRootViewControllerWithTinyTableViewController {
    ISNTinyTableViewController *tinyTableViewController = [[ISNTinyTableViewController alloc] initWithNibName:@"ISNTinyTableViewController" bundle:nil];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:tinyTableViewController];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
