//
//  KBInterfaceActionGroupSequenceView.h
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBInterfaceActionGroupView.h"
#import "KBMenuSheetItemView.h"

@interface KBInterfaceActionGroupSequenceView : KBInterfaceActionGroupView

- (instancetype)initWithItemViews:(NSArray *)itemViews;

- (void)addItemViews:(NSArray *)itemViews;

@end
