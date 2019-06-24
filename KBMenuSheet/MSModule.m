//
//  MSModule.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/6/5.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "MSModule.h"
#import <KBModule/KBModule.h>
#import <UMSocial.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSinaSSOHandler.h>
#import <UMSocialQQHandler.h>

#define UMENG_APPKEY @""
#define WX_APP_ID @""
#define WX_APP_SECRET @""

@interface MSModule ()<KBModuleProtocol>

@end

@implementation MSModule

KB_EXPORT_MODULE(NO)

- (void)moduleSetup:(KBModuleContext *)context
{
    [UMSocialData openLog:YES];
    [UMSocialData setAppKey:UMENG_APPKEY];
    [UMSocialConfig setSupportedInterfaceOrientations:UIInterfaceOrientationMaskAll];
    [UMSocialWechatHandler setWXAppId:WX_APP_ID appSecret:WX_APP_SECRET url:@"http://ckd.so/2"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"" secret:@"" RedirectURL:@"http://ckd.so/2"];
    [UMSocialQQHandler setQQWithAppId:@"" appKey:@"" url:@"http://ckd.so/2"];
    [UMSocialQQHandler setSupportWebView:YES];
}

- (void)moduleOpenURL:(KBModuleContext *)context
{
    NSURL *url = context.openURLItem.openURL;
    [UMSocialSnsService handleOpenURL:context.openURLItem.openURL wxApiDelegate:nil];
}

- (void)moduleDidBecomeActive:(KBModuleContext *)context
{
    [UMSocialSnsService  applicationDidBecomeActive];
}


@end
