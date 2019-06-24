//
//  KBActivityItemWeiboView.m
//  test5
//
//  Created by 肖雄 on 16/11/22.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBActivityItemWeiboView.h"
#if __has_include(<UMengSocial/UMSocial.h>) && __has_include(<UMengSocial/WeiboSDK.h>)
#import <UMengSocial/UMSocial.h>
#import <UMengSocial/WeiboSDK.h>
#endif

@interface KBActivityItemWeiboView ()
{
    NSString *_shareText;
    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end

@implementation KBActivityItemWeiboView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue1;
}

- (KBActivityType)activityType
{
    return KBActivityTypePostToWeibo;
}

- (NSString *)title
{
    return @"新浪微博";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_sina"];
}

- (UIImage *)shareDefaultImage
{
    return [UIImage imageNamed:@"share_software"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
#if __has_include(<UMengSocial/WeiboSDK.h>)
    return [WeiboSDK isWeiboAppInstalled];
#else
    return NO;
#endif
}

- (void)performActivity
{
    NSString *text = @"";
    if (_shareText.length > 0)
        text = _shareText;
    
    if (_shareURL.absoluteString.length > 0)
        text = [text stringByAppendingString:_shareURL.absoluteString];
    
    _shareImage = _shareImage ?: [self shareDefaultImage];
    
#if __has_include(<UMSocial.h>)
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSina]
                                                       content:text
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
