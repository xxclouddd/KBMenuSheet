//
//  KBMeunSheetView.m
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetView.h"
#import "KBMenuSheetControllerInterfaceActionGroupView.h"

const UIEdgeInsets KBMenuSheetPhoneEdgeInsets = { 10, 10, 10, 10 };
const CGFloat KBMenuSheetInterSectionSpacing = 8.0f;

@interface KBMenuSheetView ()
{
    NSMutableArray *_groupViews;
}

@end

@implementation KBMenuSheetView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        self.edgeInsets = KBMenuSheetPhoneEdgeInsets;
        self.interSectionSpacing = KBMenuSheetInterSectionSpacing;
        
        _groupViews = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithGroupViews:(NSArray *)views
{
    self = [self initWithFrame:CGRectZero];
    if (self)
    {
        [self addGroupViews:views];
    }
    return self;
}

- (void)addGroupViews:(NSArray *)views
{
    for (KBMenuSheetControllerInterfaceActionGroupView *view in views)
    {
        /*
        __weak KBMenuSheetView *weakSelf = self;
        view.layoutUpdateBlock = ^
        {
            __strong KBMenuSheetView *strongSelf = weakSelf;
            if (strongSelf == nil)
                return;
            
            [strongSelf setNeedsLayout];
        };
         */
        
        [self addSubview:view];
        [_groupViews addObject:view];
    }
}


/*
- (void)addItemViews:(NSArray *)itemViews
{
    for (KBMenuSheetItemView *itemView in itemViews)
    {
        [self addItemView:itemView hasHeader:NO hasFooter:NO];
    }
}

- (void)addItemView:(KBMenuSheetItemView *)itemView hasHeader:(bool)hasHeader hasFooter:(bool)hasFooter
{
    switch (itemView.type)
    {
        case KBMenuSheetItemTypeFooter:
        {
            if (_footerView == nil) {
                _footerView = [[KBMenuSheetControllerInterfaceActionGroupView alloc] initWithFrame:CGRectZero];
                [self insertSubview:_footerView atIndex:0];
                
                __weak KBMenuSheetView *weakSelf = self;
                _footerView.layoutUpdateBlock = ^
                {
                    __strong KBMenuSheetView *strongSelf = weakSelf;
                    if (strongSelf == nil)
                        return;
                    
                    [strongSelf setNeedsLayout];
                };
            }
            
            [_footerView addItemViews:@[itemView]];
        }
            break;
        case KBMenuSheetItemTypeDefault:
        case KBMenuSheetItemTypeHeader:
        {
            if (_mainGroupView == nil) {
                _mainGroupView = [[KBMenuSheetControllerInterfaceActionGroupView alloc] initWithFrame:CGRectZero];
                [self insertSubview:_mainGroupView atIndex:0];
                
                __weak KBMenuSheetView *weakSelf = self;
                _mainGroupView.layoutUpdateBlock = ^
                {
                    __strong KBMenuSheetView *strongSelf = weakSelf;
                    if (strongSelf == nil)
                        return;
                    
                    [strongSelf setNeedsLayout];
                };
            }
            
            [_mainGroupView addItemViews:@[itemView]];
        }
            break;
        default:
            break;
    }
}
 */

- (CGSize)groupViewSizeForGroupView:(KBMenuSheetControllerInterfaceActionGroupView *)groupView preferredWidth:(CGFloat)preferredWidth
{
    if (groupView)
    {
        groupView.preferredWidth = preferredWidth;
        return groupView.preferredSize;
    } else {
        return CGSizeZero;
    }
}

#pragma mark - 
/*
- (UIEdgeInsets)edgeInsets
{
    return KBMenuSheetPhoneEdgeInsets;
}
 */

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets
{
    _edgeInsets = edgeInsets;
    [self setNeedsLayout];
}

/*
- (CGFloat)interSectionSpacing
{
    return KBMenuSheetInterSectionSpacing;
}
 */

- (CGSize)menuSize
{
    return CGSizeMake(self.menuWidth, self.menuHeight);
}

- (CGFloat)menuHeight
{
    /*
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return MIN(screenHeight, [self menuHeightForWidth:self.menuWidth - self.edgeInsets.left - self.edgeInsets.right]);
     */
    
    CGFloat width = self.menuWidth - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat height = 0;
    
    for (KBMenuSheetControllerInterfaceActionGroupView *groupView in _groupViews)
    {
        groupView.preferredWidth = width;
        height += groupView.preferredHeight;;
    }
    
    if (height > 0) {
        height += self.edgeInsets.top + self.edgeInsets.bottom;
    }
    
    height += MAX(0, _groupViews.count - 1) * self.interSectionSpacing;
    
    return height;
}

- (CGFloat)menuHeightForWidth:(CGFloat)width
{
    
    /*
    CGFloat height = 0.0f;
    
    if (_mainGroupView)
    {
        _mainGroupView.preferredWidth = width;
        height += [_mainGroupView preferredHeight];
    }
    
    if (_footerView)
    {
        _footerView.preferredWidth = width;
        height += [_footerView preferredHeight];
    }
    
    if (height > 0)
    {
        height +=  self.edgeInsets.top + self.edgeInsets.bottom;
    }
    
    if (_mainGroupView && _footerView)
    {
        height += self.interSectionSpacing;
    }
    
    return height;
     */
    
    CGFloat height = 0;
    
    for (KBMenuSheetControllerInterfaceActionGroupView *groupView in _groupViews)
    {
        CGSize size = [self groupViewSizeForGroupView:groupView preferredWidth:width];
        height += size.height;
    }
    
    if (height > 0) {
        height += self.edgeInsets.top + self.edgeInsets.bottom;
    }
    
    height += MAX(0, _groupViews.count - 1) * self.interSectionSpacing;
    
    return height;
}

#pragma mark - 
- (void)layoutSubviews
{
    /*
    CGFloat width = self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right;
    
    UIEdgeInsets edgeInsets = self.edgeInsets;
    if (_footerView)
    {
        _footerView.preferredWidth = width;
        CGSize size = _footerView.preferredSize;
        _footerView.frame = CGRectMake(edgeInsets.left, self.bounds.size.height - edgeInsets.bottom - size.height, size.width, size.height);
    }
    
    if (_mainGroupView)
    {
        _mainGroupView.preferredWidth = width;
        CGSize size = _mainGroupView.preferredSize;
        CGFloat mainHeight = self.bounds.size.height - edgeInsets.top - edgeInsets.bottom;
        if (_footerView) {
            mainHeight -= CGRectGetHeight(_footerView.frame);
            mainHeight -= self.interSectionSpacing;
        }
        _mainGroupView.frame = CGRectMake(edgeInsets.left, edgeInsets.top, size.width, mainHeight);
    }
    
    if (self.menuRelayout != nil) {
        self.menuRelayout();
    }
     */
    
    CGFloat width = self.frame.size.width - self.edgeInsets.left - self.edgeInsets.right;
    CGFloat height = self.edgeInsets.top;
    
    for (KBMenuSheetControllerInterfaceActionGroupView *groupView in _groupViews)
    {
        CGSize size = [self groupViewSizeForGroupView:groupView preferredWidth:width];
        groupView.frame = CGRectMake(ceil((self.bounds.size.width - size.width) / 2.0) ,height, size.width, size.height);
        
        height += size.height;
        height += self.interSectionSpacing;
    }
    
    if (self.menuRelayout != nil) {
        self.menuRelayout();
    }
}

@end


