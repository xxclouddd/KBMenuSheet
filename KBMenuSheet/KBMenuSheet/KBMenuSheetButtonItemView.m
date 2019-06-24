//
//  KBMenuSheetButtonItemView.m
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBMenuSheetButtonItemView.h"

const CGFloat KBMenuSheetButtonItemViewHeight = 49.0f;  //57.0f

@interface KBMenuSheetButtonItemView ()
{
    UIButton *_button;
}

@end

@implementation KBMenuSheetButtonItemView

- (instancetype)initWithTitle:(NSString *)title action:(void (^)(void))action
{
    return [self initWithTitle:title type:KBMenuSheetButtonTypeDefault action:action];
}

- (instancetype)initWithTitle:(NSString *)title type:(KBMenuSheetButtonType)type action:(void (^)(void))action
{
    self = [super initWithType:(type == KBMenuSheetButtonTypeCancel) ? KBMenuSheetItemTypeFooter : KBMenuSheetItemTypeDefault];
    if (self)
    {
        _action = action;
        _dismissAutomatically = YES;
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.exclusiveTouch = true;
        [_button setTitle:title forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor colorWithRed:52/255.0 green:52/255.0 blue:52/255.0 alpha:1.0] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:17];
        [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_button];        
    }
    return self;
}

- (void)buttonPressed:(__unused UIButton *)sender
{
    if (_action != nil) {
        _action();
    }
    
    if (self.dismissAutomatically && self.menuSheetController) {
        [self.menuSheetController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (CGFloat)preferredHeightForWidth:(CGFloat)__unused width screenHeight:(CGFloat)__unused screenHeight
{
    return KBMenuSheetButtonItemViewHeight;
}

- (void)setTitle:(NSString *)title
{
    [_button setTitle:title forState:UIControlStateNormal];
}

- (NSString *)title
{
    return [_button titleForState:UIControlStateNormal];
}

#pragma mark - 
- (void)layoutSubviews
{
    _button.frame = self.bounds;
}


@end
