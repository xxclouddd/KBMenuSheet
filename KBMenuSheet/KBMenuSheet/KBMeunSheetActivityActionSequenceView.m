//
//  KBMeunSheetActivityActionSequenceView.m
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMeunSheetActivityActionSequenceView.h"

@interface KBMeunSheetActivityActionSequenceView ()
{
    UIScrollView *_scrollView;
    
    NSMutableArray *_itemViews;
}

@end

@implementation KBMeunSheetActivityActionSequenceView

- (instancetype)initWithActivityItemViews:(NSArray<KBActivityItemView *> *)items
{
    self = [super initWithType:KBMenuSheetItemTypeDefault];
    if (self)
    {
        _itemViews = [NSMutableArray array];
        
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.canCancelContentTouches = YES;
        _scrollView.bounces = YES;
        [self addSubview:_scrollView];
        
        [self addItems:items];
    }
    return self;
}

- (void)addItems:(NSArray<KBActivityItemView *> *)items
{
    for (KBActivityItemView *view in items)
    {
        [view sizeToFit];
        
        [_scrollView addSubview:view];
        [_itemViews addObject:view];
    }
    
    if (items.count > 0) {
        [self setNeedsLayout];
    }
}

- (CGFloat)internalSpace
{
    return 16;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)__unused width screenHeight:(CGFloat)__unused screenHeight
{
    return 125;
}

- (void)layoutSubviews
{
    _scrollView.frame = self.bounds;
    
    UIEdgeInsets inset = UIEdgeInsetsMake(15, 13, 25, 13);
    CGFloat left = inset.left;
    
    NSInteger index = -1;
    for (KBActivityItemView *view in _itemViews)
    {
        index ++;
        
        CGSize itemSize = view.frame.size;
        view.frame = CGRectMake(left, inset.top, itemSize.width, itemSize.height);
        
        left += itemSize.width;
        left += self.internalSpace;
    }
    
    _scrollView.contentSize = CGSizeMake(left - self.internalSpace + inset.right, self.bounds.size.height);
}


@end
