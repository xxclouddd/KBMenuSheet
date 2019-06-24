//
//  AppDelegate.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/3/2.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [KBModuleContext shareInstance].application = application;
    [KBModuleContext shareInstance].launchOptions = launchOptions;
    [KBModuleContext shareInstance].env = KBEnvironmentDevelop;
    
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    return YES;
}

/*
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}
 */


@end
