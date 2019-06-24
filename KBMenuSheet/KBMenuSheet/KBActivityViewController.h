//
//  KBActivityViewController.h
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBActivityItemView.h"
#import "KBMenuSheetItemView.h"

NS_ASSUME_NONNULL_BEGIN

/*
 NSString *shareTitle = @"title:This is test";
 NSString *shareText = @"content:Time will tell how much I love you";
 */

@interface KBActivityViewController : UIViewController

@property (nullable, nonatomic, copy) void(^didFinishHandle)(NSError * _Nullable error);

- (instancetype)initWithActivityItems:(NSArray *)activityItems activities:(nullable NSArray<__kindof KBActivityItemView *> *)activities;

- (instancetype)initWithActivityItems:(NSArray *)activityItems activities:(NSArray<__kindof KBActivityItemView *> *)activities headerItem:(nullable KBMenuSheetItemView *)headerItem;

@property(nullable ,nonatomic, copy) NSArray<KBActivityType> *excludedActivityTypes;

@end


NS_ASSUME_NONNULL_END
