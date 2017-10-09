//
//  KBInterfaceActionGroupSequenceView.m
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBInterfaceActionGroupSequenceView.h"

@interface KBInterfaceActionGroupSequenceView()
{
    NSMutableArray *_itemViews;
}

@end

@implementation KBInterfaceActionGroupSequenceView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithType:KBInterfaceActionGroupViewTypeDefault];
    if (self)
    {
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithItemViews:(NSArray *)itemViews
{
    self = [super initWithType:KBInterfaceActionGroupViewTypeDefault];
    if (self)
    {
        _itemViews = [NSMutableArray array];
    }
    return self;
}

- (void)addItemViews:(NSArray *)itemViews
{
    if (itemViews.count > 0)
    {
        [_itemViews addObjectsFromArray:itemViews];
        
        for (KBMenuSheetItemView *view in itemViews) {
            [self addSubview:view];
        }
        [self layoutSubviews];

        if (self.layoutUpdateBlock) {
            self.layoutUpdateBlock();
        }
    }
}

- (CGFloat)preferredHeight
{
    CGFloat contentHeight = 0;
    for (KBMenuSheetItemView *itemView in _itemViews)
    {
        CGFloat height = [itemView preferredHeightForWidth:self.preferredWidth screenHeight:0];
        contentHeight += height;
    }
    return contentHeight;
}

-(void)layoutSubviews
{
    CGRect bounds = self.bounds;
    CGFloat contentHeight = 0;

    for (KBMenuSheetItemView *itemView in _itemViews)
    {
        CGFloat height = [itemView preferredHeightForWidth:bounds.size.height screenHeight:0];
        itemView.frame = CGRectMake(0, contentHeight, bounds.size.height, height);
        contentHeight += height;
    }
}


@end
