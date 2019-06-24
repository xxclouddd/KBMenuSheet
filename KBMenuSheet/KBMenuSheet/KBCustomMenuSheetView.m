//
//  KBCustomMenuSheetView.m
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBCustomMenuSheetView.h"

@interface KBCustomMenuSheetView ()
{
    KBMenuSheetControllerInterfaceActionGroupView *_mainView;
    KBMenuSheetControllerInterfaceActionGroupView *_footerView;
    
    CGFloat _contentHeight;
}

@end

@implementation KBCustomMenuSheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithItemViews:(NSArray *)itemViews
{
    self = [super initWithGroupViews:nil];
    if (self)
    {
        [self addItemViews:itemViews];
    }
    
    return self;
}

- (void)addItemViews:(NSArray *)itemViews
{
    for (KBMenuSheetItemView *itemView in itemViews)
    {
        [self addItemView:itemView];
    }
}

- (void)addItemView:(KBMenuSheetItemView *)itemView
{
    switch (itemView.type)
    {
        case KBMenuSheetItemTypeFooter:
        {
            if (_footerView == nil)
            {
                _footerView = [[KBMenuSheetControllerInterfaceActionGroupView alloc] initWithFrame:CGRectZero];
                _footerView.layer.cornerRadius = 0.0;
                _footerView.useEffectView = NO;
                [self addGroupViews:@[_footerView]];
            }
            
            [_footerView addItemViews:@[itemView]];
        }
            break;
        case KBMenuSheetItemTypeDefault:
        case KBMenuSheetItemTypeHeader:
        {
            if (_mainView == nil)
            {
                _mainView = [[KBMenuSheetControllerInterfaceActionGroupView alloc] initWithFrame:CGRectZero];
                _mainView.layer.cornerRadius = 0.0;
                _mainView.useEffectView = NO;
                [self addGroupViews:@[_mainView]];
            }
            
            [_mainView addItemViews:@[itemView]];
        }
            break;
        default:
            break;
    }
}

- (CGSize)groupViewSizeForGroupView:(KBMenuSheetControllerInterfaceActionGroupView *)groupView preferredWidth:(CGFloat)preferredWidth
{
    if (groupView == _mainView)
    {
        CGSize size = [super groupViewSizeForGroupView:groupView preferredWidth:preferredWidth];
        CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
        CGFloat menuHeight = [super menuHeight];
        
        if (menuHeight > screenHeight)
            size.height -= menuHeight - screenHeight;
        
        return size;
    }
    else
        return [super groupViewSizeForGroupView:groupView preferredWidth:preferredWidth];
}

- (CGFloat)menuHeight
{
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    return MIN(screenHeight, [super menuHeight]);
}

- (KBMenuSheetControllerInterfaceActionGroupView *)mainView
{
    return _mainView;
}

- (KBMenuSheetControllerInterfaceActionGroupView *)footerView
{
    return _footerView;
}


@end
