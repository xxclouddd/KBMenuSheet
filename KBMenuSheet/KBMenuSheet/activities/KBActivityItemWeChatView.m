//
//  KBActiKBActivityItemWeChatView.m
//  test5
//
//  Created by 肖雄 on 16/11/22.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBActivityItemWeChatView.h"
#if __has_include(<UMSocial.h>)
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/WXApi.h>
#endif

@interface KBActivityItemWeChatView ()
{
    NSString *_shareTitle;
    NSString *_shareText;
    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end

@implementation KBActivityItemWeChatView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue1;
}

- (KBActivityType)activityType
{
    return KBActivityTypePostToWeChat;
}

- (NSString *)title
{
    return @"微信好友";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_wechat"];
}

- (UIImage *)shareDefaultImage
{
    return [UIImage imageNamed:@"share_software"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
#if __has_include(<UMSocial.h>) 
    return [WXApi isWXAppInstalled];
#elif DEBUG
    return YES;
#else 
    return NO;
#endif
}

- (void)performActivity
{
    _shareImage = _shareImage ?: [self shareDefaultImage];
    
#if __has_include(<UMSocial.h>)
    [UMSocialDataService defaultDataService].socialData.extConfig.wechatSessionData.url = _shareURL.absoluteString;
    [UMSocialDataService defaultDataService].socialData.extConfig.wechatSessionData.title = _shareTitle ?: @"";

    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatSession]
                                                       content:_shareText
                                                         image:_shareImage
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:self.activityViewController
                                                    completion:^(UMSocialResponseEntity *response)
    {
        // About um shared can't call back after completed.
        // http://www.jianshu.com/p/177e3309272a
        NSError *error = nil;
        if (response.responseCode != UMSResponseCodeSuccess) {
            error = [NSError errorWithDomain:@"" code:response.responseCode userInfo:@{NSLocalizedDescriptionKey: response.message ?: @""}];
        }
        [self activityDidFinish:error];
    }];
#endif
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    _shareTitle = [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSString class]] && [evaluatedObject hasPrefix:@"title:"];
    }]] firstObject];
    
    if ([_shareTitle hasPrefix:@"title:"]) {
        _shareTitle = [_shareTitle substringFromIndex:6];
    }
    
    _shareText = [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSString class]] && ([evaluatedObject hasPrefix:@"content:"] || ![evaluatedObject hasPrefix:@"title:"]);
    }]] firstObject];
    
    if ([_shareText hasPrefix:@"content:"]) {
        _shareText = [_shareText substringFromIndex:8];
    }
    
    _shareImage =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[UIImage class]];
    }]] firstObject];
    
    _shareURL =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSURL class]];
    }]] firstObject];
}

@end
