//
//  KBMeunSheetView.h
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBMenuSheetControllerInterfaceActionGroupView.h"

@interface KBMenuSheetView : UIView

@property (nonatomic, readonly) NSArray *itemViews;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) CGFloat interSectionSpacing;

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, readonly) CGFloat menuHeight;
@property (nonatomic, readonly) CGSize menuSize;

@property (nonatomic, copy) void (^menuRelayout)(void);

- (instancetype)initWithGroupViews:(NSArray<KBMenuSheetControllerInterfaceActionGroupView *> *)views;

- (void)addGroupViews:(NSArray *)views;

- (CGSize)groupViewSizeForGroupView:(KBMenuSheetControllerInterfaceActionGroupView *)groupView preferredWidth:(CGFloat)preferredWidth;

@end
