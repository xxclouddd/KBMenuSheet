//
//  KBMenuSheetControllerInterfaceActionGroupView.h
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMenuSheetItemView.h"

@interface KBMenuSheetControllerInterfaceActionGroupView : UIView

- (instancetype)initWithItemViews:(NSArray *)itemViews;
- (void)addItemViews:(NSArray *)itemViews;

@property (nonatomic, readonly) NSArray <KBMenuSheetItemView *> *items;
@property (nonatomic, copy) void (^layoutUpdateBlock)(void);

@property (nonatomic, assign) CGFloat preferredWidth;
@property (nonatomic, readonly) CGFloat preferredHeight;
@property (nonatomic, readonly) CGSize preferredSize;

@property (nonatomic, assign) BOOL useEffectView;  // default is YES;

@end
