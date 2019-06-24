//
//  KBMenuSheetItemView.h
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KBMenuSheetView;

typedef NS_ENUM(NSInteger, KBMenuSheetItemType) {
    KBMenuSheetItemTypeDefault,
    KBMenuSheetItemTypeHeader,
    KBMenuSheetItemTypeFooter
};

@interface KBMenuSheetItemView : UIView

@property (nonatomic, readonly) KBMenuSheetItemType type;

- (instancetype)initWithType:(KBMenuSheetItemType)type;

- (CGFloat)preferredHeightForWidth:(CGFloat)width screenHeight:(CGFloat)screenHeight;

@property (nonatomic, copy) void (^layoutUpdateBlock)(void);
- (void)requestMenuLayoutUpdate;

@property (nonatomic, weak) UIView *dividerView;


//- (void)menuView:(KBMenuSheetView *)menuView willAppearAnimated:(BOOL)animated;
//- (void)menuView:(KBMenuSheetView *)menuView didAppearAnimated:(BOOL)animated;
//- (void)menuView:(KBMenuSheetView *)menuView willDisappearAnimated:(BOOL)animated;
//- (void)menuView:(KBMenuSheetView *)menuView didDisappearAnimated:(BOOL)animated;

@end
