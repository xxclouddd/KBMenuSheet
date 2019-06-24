//
//  KBActivityItemMessageView.m
//  test5
//
//  Created by 肖雄 on 16/11/22.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBActivityItemMessageView.h"
#if __has_include(<UMSocial.h>)
#import <UMengSocial/UMSocial.h>
#endif

@interface KBActivityItemMessageView ()
{
    NSString *_shareText;
//    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end

@implementation KBActivityItemMessageView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue2;
}

- (KBActivityType)activityType
{
    return KBActivityTypeMessage;
}

- (NSString *)title
{
    return @"短信";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_note"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)performActivity
{
    NSString *text = @"";
    if (_shareText.length > 0)
        text = _shareText;
    
    if (_shareURL.absoluteString.length > 0)
        text = [text stringByAppendingString:_shareURL.absoluteString];

#if __has_include(<UMSocial.h>)
    [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToSms]
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
    _shareText = [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSString class]] && ([evaluatedObject hasPrefix:@"content:"] || ![evaluatedObject hasPrefix:@"title:"]);
    }]] firstObject];
    
    if ([_shareText hasPrefix:@"content:"]) {
        _shareText = [_shareText substringFromIndex:8];
    }
    
//    _shareImage =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [evaluatedObject isKindOfClass:[UIImage class]];
//    }]] firstObject];
    
    _shareURL =  [[activityItems filteredArrayUsingPredicate: [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject isKindOfClass:[NSURL class]];
    }]] firstObject];
}


@end
