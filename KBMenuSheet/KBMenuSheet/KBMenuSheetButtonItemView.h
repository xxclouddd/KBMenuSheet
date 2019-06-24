//
//  KBMenuSheetButtonItemView.h
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBMenuSheetItemView.h"

typedef NS_ENUM(NSInteger, KBMenuSheetButtonType) {
    KBMenuSheetButtonTypeDefault,
    KBMenuSheetButtonTypeCancel,
    KBMenuSheetButtonTypeDestructive,
};

@interface KBMenuSheetButtonItemView : KBMenuSheetItemView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) void(^action)();

@property (nonatomic) BOOL dismissAutomatically;
@property (nonatomic, weak) UIViewController *menuSheetController;

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(void))action;
- (instancetype)initWithTitle:(NSString *)title type:(KBMenuSheetButtonType)type action:(void (^)(void))action;

@end
