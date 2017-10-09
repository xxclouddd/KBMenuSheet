//
//  KBMeunSheetActivityActionSequenceView.h
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetItemView.h"
#import "KBActivityItemView.h"

@interface KBMeunSheetActivityActionSequenceView : KBMenuSheetItemView

@property (nonatomic, readonly) CGFloat internalSpace;

- (instancetype)initWithActivityItemViews:(NSArray<KBActivityItemView *> *)items;

- (void)addItems:(NSArray<KBActivityItemView *> *)items;

@end

