//
//  KBKBActivityItemWeChatMomentView.m
//  test5
//
//  Created by 肖雄 on 16/11/21.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBActivityItemWeChatMomentView.h"

#if __has_include(<UMSocial.h>)
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/WXApi.h>
#endif

@interface KBActivityItemWeChatMomentView ()
{
    NSString *_shareTitle;
    NSString *_shareText;
    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end

@implementation KBActivityItemWeChatMomentView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue1;
}

- (KBActivityType)activityType
{
    return KBActivityTypePostToWeChatMoment;
}

- (NSString *)title
{
    return @"朋友圈";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_friends"];
}

- (UIImage *)shareDefaultImage
{
    return [UIImage imageNamed:@"share_software"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
#if __has_include(<UMSocial.h>)
    return [WXApi isWXAppInstalled];
#endif
    
#if DEBUG
    return YES;
#else
    return NO;
#endif
}

- (void)performActivity
{
    _shareImage = _shareImage ?: [self shareDefaultImage];
    
#if __has_include(<UMSocial.h>)
    [UMSocialDataService defaultDataService].socialData.extConfig.wechatTimelineData.url = _shareURL.absoluteString;
    [UMSocialDataService defaultDataService].socialData.extConfig.wechatTimelineData.title = _shareTitle ?: @"";

    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToWechatTimeline]
                                                       content:_shareText
                                                         image:_shareImage
                                                      location:nil
                                                   urlResource:nil
                                           presentedController:self.activityViewController
                                                    completion:^(UMSocialResponseEntity *response)
     {
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
