//
//  KBActivityItemCopyToPasteboardView.m
//  test5
//
//  Created by 肖雄 on 16/11/22.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBActivityItemCopyToPasteboardView.h"

@interface KBActivityItemCopyToPasteboardView ()
{
    NSString *_shareText;
    UIImage *_shareImage;
    NSURL *_shareURL;
}

@end


@implementation KBActivityItemCopyToPasteboardView

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue2;
}

- (KBActivityType)activityType
{
    return KBActivityTypeCopyToPasteboard;
}

- (NSString *)title
{
    return @"复制链接";
}

- (UIImage *)image
{
    return [UIImage imageNamed:@"share_link"];
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)performActivity
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (_shareURL)
    {
        [pasteboard setString:_shareURL.absoluteString];
    }
    else if (_shareText)
    {
        [pasteboard setString:_shareText];
    }

    [self activityDidFinish:nil];
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
