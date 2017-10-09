//
//  KBActivityItemView.h
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KBActivityItemViewCategory) {
    KBActivityItemViewCategoryValue1,
    KBActivityItemViewCategoryValue2
};

typedef NSString * KBActivityType;

extern KBActivityType const KBActivityTypePostToWeChatMoment;
extern KBActivityType const KBActivityTypePostToWeChat;
extern KBActivityType const KBActivityTypePostToQQ;
extern KBActivityType const KBActivityTypePostToQQZone;
extern KBActivityType const KBActivityTypePostToWeibo;
extern KBActivityType const KBActivityTypeMail;
extern KBActivityType const KBActivityTypeMessage;
extern KBActivityType const KBActivityTypeCopyToPasteboard;

@interface KBActivityItemView : UIView

@property (nonatomic, assign, readonly) KBActivityItemViewCategory activityCategory;
@property (nonatomic, assign, readonly) KBActivityType activityType;

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) UIImage *image;

@property (nonatomic, strong) UIViewController *activityViewController;
@property (nonatomic) BOOL dismissAutomatically;

@property (nonatomic, copy) void(^willSelectHandle)();
@property (nonatomic, copy) void(^didSelectHandle)();
@property (nonatomic, copy) void(^didFinishHandle)(NSError *error);

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems;
- (void)prepareWithActivityItems:(NSArray *)activityItems;

- (void)performActivity;
- (void)activityDidFinish:(NSError *)error;  // activity must call this when activity is finished

@end
