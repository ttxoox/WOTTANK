//
//  AppDelegate.m
//  WOT
//
//  Created by GVS on 16/8/30.
//  Copyright © 2016年 GVS. All rights reserved.
//

#import "AppDelegate.h"
#import "ZM_NavigationViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

-(void)createTB
{
    NSMutableArray * navArray = [[NSMutableArray alloc] init];
//    NSMutableArray * clsNameArray = [[NSMutableArray alloc] init];
    NSArray * array = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"tabbar" ofType:@"plist"]];
    for (NSDictionary * dict in array) {
        UIViewController * rootVc = [[NSClassFromString(dict[@"clsName"]) alloc] init];
        ZM_NavigationViewController * navi = [[ZM_NavigationViewController alloc] initWithRootViewController:rootVc];
        navi.tabBarItem.title = dict[@"name"];
        navi.tabBarItem.image = [[UIImage imageNamed:dict[@"imgName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        navi.tabBarItem.selectedImage = [[UIImage imageNamed:dict[@"selectImgName"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [navArray addObject:navi];
    }
    UITabBarController * tabbar = [[UITabBarController alloc] init];
    tabbar.viewControllers = navArray;
    self.window.rootViewController = tabbar;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.page = 0;
    [self createTB];
    [self.window makeKeyAndVisible];
    return YES;
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
