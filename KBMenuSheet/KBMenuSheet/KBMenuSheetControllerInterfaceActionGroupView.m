//
//  KBMenuSheetControllerInterfaceActionGroupView.m
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetControllerInterfaceActionGroupView.h"

const CGFloat KBMenuSheetCornerRadius = 14.5f;
const bool KBMenuSheetUseEffectView = true;

#define KBMenuSheetSeparatorColor [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];

@interface KBMenuSheetScrollView : UIScrollView

@end

@implementation KBMenuSheetScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil)
    {
        self.showsHorizontalScrollIndicator = false;
        self.showsVerticalScrollIndicator = false;
    }
    return self;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)__unused view
{
    return true;
}

@end

@interface KBMenuSheetControllerInterfaceActionGroupView ()
{
    UIVisualEffectView *_effectView;
    UIImageView *_imageView;
    KBMenuSheetScrollView *_scrollView;
    
    NSMutableArray *_itemViews;
    
    bool _hasHeader;
    bool _hasRegularItems;
}

@end

@implementation KBMenuSheetControllerInterfaceActionGroupView

- (NSArray<KBMenuSheetItemView *> *)items
{
    return _itemViews;
}

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [self initWithItemViews:nil];
    if (self) {
        self.frame = frame;
    }
    return self;
}

- (instancetype)initWithItemViews:(NSArray *)itemViews
{
    self = [super initWithFrame:CGRectZero];
    if (self)
    {
        self.clipsToBounds = true;
        self.layer.cornerRadius = KBMenuSheetCornerRadius;
        
        _useEffectView = KBMenuSheetUseEffectView;
        [self _setBackgroundView];
        
        _itemViews = [NSMutableArray array];
        
        [self addItemViews:itemViews];
    }
    
    return self;
}

- (void)_setBackgroundView
{
    if (self.useEffectView)
    {
        _effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
        _effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _effectView.frame = self.bounds;
        [self insertSubview:_effectView atIndex:0];
    }
    else
    {
        /*
        static dispatch_once_t onceToken;
        static UIImage *backgroundImage;
        dispatch_once(&onceToken, ^
        {
            CGRect rect = CGRectMake(0, 0, KBMenuSheetCornerRadius * 2 + 1, KBMenuSheetCornerRadius * 2 + 1);
            UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0f);
            CGContextRef context = UIGraphicsGetCurrentContext();
            
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:KBMenuSheetCornerRadius] fill];
            
            backgroundImage = [UIGraphicsGetImageFromCurrentImageContext() resizableImageWithCapInsets:UIEdgeInsetsMake(KBMenuSheetCornerRadius, KBMenuSheetCornerRadius, KBMenuSheetCornerRadius, KBMenuSheetCornerRadius)];
            UIGraphicsEndImageContext();
        });
        */
        
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];

        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _imageView.frame = self.bounds;
        [self insertSubview:_imageView atIndex:0];
    }
}

- (void)setUseEffectView:(BOOL)useEffectView
{
    if (_useEffectView != useEffectView)
    {
        _useEffectView = useEffectView;
        
        if ([self.subviews firstObject] == _effectView) {
            [_effectView removeFromSuperview];
        }
        
        if ([self.subviews firstObject] == _imageView) {
            [_imageView removeFromSuperview];
        }
        
        [self _setBackgroundView];
    }
}

- (void)addItemViews:(NSArray *)itemViews
{
    if (itemViews.count > 0)
    {
        //bool layout = false;
        
        for (KBMenuSheetItemView *view in itemViews)
        {
            view.tag = _itemViews.count;
            
            if (view.type == KBMenuSheetItemTypeHeader)
            {
                if (_hasHeader) continue;
                
                [self addSubview:view];
                [_itemViews insertObject:view atIndex:0];
                
                _hasHeader = true;
                //layout = true;
                
                UIView *divider = [self createDividerWithItemView:view];
                if (divider)
                {
                    [self addSubview:divider];
                    view.dividerView = divider;
                }
            }
            else
            {
                if (_scrollView == nil) {
                    _scrollView = [[KBMenuSheetScrollView alloc] initWithFrame:CGRectZero];
                    [self addSubview:_scrollView];
                }
                
                [_scrollView addSubview:view];
                [_itemViews addObject:view];
                
                _hasRegularItems = true;
                //layout = true;
                
                UIView *divider = [self createDividerWithItemView:view];
                if (divider)
                {
                    /*
                    if (_hasHeader && [_itemViews indexOfObject:view] == 1)
                        [self addSubview:divider];
                     else
                        [_scrollView addSubview:divider];
                     */
                    [_scrollView addSubview:divider];
                    view.dividerView = divider;
                }
            }
            
            /*
            __weak KBMenuSheetControllerInterfaceActionGroupView *weakSelf = self;
            view.layoutUpdateBlock = ^
            {
                __strong KBMenuSheetControllerInterfaceActionGroupView *strongSelf = weakSelf;
                if (strongSelf == nil)
                    return;
                
                [strongSelf setNeedsLayout];
            };
             */
        }
        
        /*
        if (layout)
        {
            [self setNeedsLayout];
        }
         */
    }
}

- (CGSize)preferredSize
{
    return CGSizeMake(self.preferredWidth, self.preferredHeight);
}

- (CGFloat)preferredHeight
{
    CGFloat height = 0.0;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    for (KBMenuSheetItemView *itemView in _itemViews)
    {
        height += [itemView preferredHeightForWidth:self.preferredWidth screenHeight:screenHeight];
    }
    
    return height;
}

- (KBMenuSheetItemView *)headerItemView
{
    if ([(KBMenuSheetItemView *)_itemViews.firstObject type] == KBMenuSheetItemTypeHeader)
        return _itemViews.firstObject;
    
    return nil;
}

- (UIView *)createDividerWithItemView:(KBMenuSheetItemView *)itemView
{
    if (!itemView)
        return nil;
    
    /*
    NSInteger index = [_itemViews indexOfObject:itemView];
    
    KBMenuSheetItemView *previousView = nil;
    if (index - 1 >= 0 && index - 1 < _itemViews.count) {
        previousView = _itemViews[index - 1];
    }
    
    KBMenuSheetItemView *nextView = nil;
    if (index + 1 < _itemViews.count) {
        nextView = _itemViews[index + 1];
    }

    UIView *divider = _divierViews[@(itemView.tag)];
    if (!previousView && (nextView && divider)) {
        return nil;
    }
    
    BOOL isRetina =  [[UIScreen mainScreen] scale] > 1.5f;
    UIView *bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, isRetina ? 0.5f : 1.0f)];
    bottomDivider.backgroundColor = KBMenuSheetSeparatorColor;
    
    if (previousView && !_divierViews[@(previousView.tag)]) {
        [_divierViews setObject:bottomDivider forKey:@(previousView.tag)];
        return bottomDivider;
    } else if (!previousView && !divider && nextView) {
        [_divierViews setObject:bottomDivider forKey:@(itemView.tag)];
        return bottomDivider;
    } else {
        return nil;
    }
     */
    
    
    UIView *divider = itemView.dividerView;
    if (divider)
        return nil;
    
    BOOL isRetina =  [[UIScreen mainScreen] scale] > 1.5f;
    UIView *bottomDivider = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, isRetina ? 0.5f : 1.0f)];
    bottomDivider.backgroundColor = KBMenuSheetSeparatorColor;

    return bottomDivider;
}

#pragma mark -
- (void)layoutSubviews
{
    CGSize size = self.bounds.size;
    CGFloat top = 0;

    KBMenuSheetItemView *headerItemView = [self headerItemView];
    if (headerItemView != nil)
    {
        CGFloat height = [headerItemView preferredHeightForWidth:size.width screenHeight:0];
        headerItemView.frame = CGRectMake(0, 0, size.width, height);
        top += height;
        
        UIView *divider = headerItemView.dividerView;
        if (divider) {
            divider.frame = CGRectMake(0, CGRectGetMaxY(headerItemView.frame) - divider.frame.size.height, size.width, divider.frame.size.height);
        }
        
        headerItemView.dividerView = divider;
    }
    
    _scrollView.frame = CGRectMake(0, top, size.width, size.height - top);
    
    CGFloat contentHeight = 0;
    for (KBMenuSheetItemView *itemView in _itemViews)
    {
        if (itemView == headerItemView) continue;
        CGFloat height = [itemView preferredHeightForWidth:size.width screenHeight:0];
        itemView.frame = CGRectMake(0, contentHeight, size.width, height);
        contentHeight += height;
        
        UIView *divider = itemView.dividerView;
        if (divider) {
            divider.frame = CGRectMake(0, CGRectGetMaxY(itemView.frame) - divider.frame.size.height, size.width, divider.frame.size.height);
        }
    }
    
    _scrollView.contentSize = CGSizeMake(size.width, contentHeight);
    
    if (self.layoutUpdateBlock) {
        self.layoutUpdateBlock();
    }
}

@end



