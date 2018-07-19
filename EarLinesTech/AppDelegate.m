//
//  AppDelegate.m
//  ERWENKEJI
//
//  Created by  RWLi on 2018/4/9.
//  Copyright © 2018年  RWLi. All rights reserved.
//

#import "AppDelegate.h"
#import "JSHAREService.h"
#import "HomePageViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
    BOOL isfirstApp = [[NSUserDefaults standardUserDefaults]boolForKey:FISTAPP];
    if (!isfirstApp) {
        //第一次进入app,开启介绍图
        UIScrollView *SC =[[UIScrollView alloc]initWithFrame:_window.bounds];
        SC.tag = 100;
        UIButton *intoBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        intoBtn.backgroundColor = [UIColor blueColor];
        [intoBtn setFrame:CGRectMake(0, 0, 100, 30)];
        intoBtn.center = SC.center;
        [intoBtn addTarget:self action:@selector(intoBtn:) forControlEvents:UIControlEventTouchUpInside];
        [intoBtn setTitle:@"广告界面进入" forState:UIControlStateNormal];
        [SC addSubview:intoBtn];
        UIViewController *adVC =  [[UIViewController alloc]init];
        [adVC.view addSubview:SC];
        _window.rootViewController = adVC;
        [_window makeKeyAndVisible];
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:FISTAPP];
    }else{
        [self intoMainPage];
    }
    
    
    
    //分享
    JSHARELaunchConfig *config = [[JSHARELaunchConfig alloc] init];
    config.appKey = @"706dd7a544b4f5030a104b16";
    config.QQAppId = @"1106866420";
    config.QQAppKey = @"FOAFu5y9q81PbqI0";
    config.WeChatAppId = @"wxc40e16f3ba6ebabc";
    config.WeChatAppSecret = @"dcad950cd0633a27e353477c4ec12e7a";
    [JSHAREService setupWithConfig:config];
    [JSHAREService setDebug:NO];
    
    
    return YES;
}

-(void)intoMainPage{
    HomePageViewController *mainVC = [[HomePageViewController alloc]initWithNibName:@"HomePageViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc]initWithRootViewController:mainVC];
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontsize],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    nav.navigationBar.barTintColor = [ UIColor redColor];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    _window.rootViewController = nav;
    [nav setNavigationBarHidden:YES];
    [_window makeKeyAndVisible];
}

-(void)intoBtn:(UIButton *)sender{
    sender.enabled = NO;
    [self intoMainPage];
    
}

-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    [JSHAREService handleOpenUrl:url];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
