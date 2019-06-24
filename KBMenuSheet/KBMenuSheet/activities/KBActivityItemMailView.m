//
//  KBActivityItemViewMailView.m
//  test5
//
//  Created by 肖雄 on 16/11/22.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBActivityItemMailView.h"
#if __has_include(<UMSocial.h>)
#import <UMengSocial/UMSocial.h>
#endif

@interface KBActivityItemMailView ()
{
    NSString *_shareTitle;
    NSString *_shareText;
//    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end

@implementation KBActivityItemMailView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue2;
}

- (KBActivityType)activityType
{
    return KBActivityTypeMail;
}

- (NSString *)title
{
    return @"邮件";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_mail"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)performActivity
{
    if (self.didSelectHandle) {
        self.didSelectHandle();
    }

    
    NSString *text = @"";
    if (_shareText.length > 0)
        text = _shareText;
    
    if (_shareURL.absoluteString.length > 0)
        text = [text stringByAppendingString:_shareURL.absoluteString];
    
#if __has_include(<UMSocial.h>)
    [UMSocialDataService defaultDataService].socialData.extConfig.emailData.title = _shareTitle;
    
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToEmail]
                                                       content:text
                                                         image:nil
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
    
//    _shareImage =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject isKindOfClass:[UIImage class]];
//    }]] firstObject];
//    
    _shareURL =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSURL class]];
    }]] firstObject];
}

@end
