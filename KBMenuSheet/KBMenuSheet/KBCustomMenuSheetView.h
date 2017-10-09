//
//  KBCustomMenuSheetView.h
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetView.h"
#import "KBMenuSheetItemView.h"
#import "KBMenuSheetControllerInterfaceActionGroupView.h"

@interface KBCustomMenuSheetView : KBMenuSheetView

- (instancetype)initWithItemViews:(NSArray *)itemViews;

@property (nonatomic, readonly) KBMenuSheetControllerInterfaceActionGroupView *mainView;
@property (nonatomic, readonly) KBMenuSheetControllerInterfaceActionGroupView *footerView;

@end
