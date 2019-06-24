//
//  KBMenuSheetController.h
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMenuSheetItemView.h"
#import "KBMenuSheetButtonItemView.h"
#import "KBMenuSheetHeaderItemView.h"

@interface KBMenuSheetController : UIViewController

- (instancetype)initWithItemViews:(NSArray<KBMenuSheetItemView *> *)itemViews;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message itemViews:(NSArray<KBMenuSheetItemView *> *)itemViews;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message defaultCancel:(BOOL)cancel itemViews:(NSArray<KBMenuSheetItemView *> *)itemViews;

- (void)setItemViews:(NSArray<KBMenuSheetItemView *> *)itemViews animated:(bool)animated;

@end
