//
//  KBMenuSheetHeaderItemView.m
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBMenuSheetHeaderItemView.h"

const CGFloat KBMenuSheethHeaderItemViewInternalSpace = 8.0f;

@interface KBMenuSheetHeaderItemView ()
{
    UILabel *_titleLabel;
    UILabel *_messageLabel;
}

@end

@implementation KBMenuSheetHeaderItemView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message
{
    self = [super initWithType:KBMenuSheetItemTypeHeader];
    if (self)
    {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = title;
        _titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleLabel];
        
        _messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _messageLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:14];
        _messageLabel.numberOfLines = 0;
        _messageLabel.text = message;
        _messageLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_messageLabel];
        
        _title = title;
        _message = message;
        _insets = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    if (![_title isEqualToString:title])
    {
        _title = title;
        _titleLabel.text = title;
        [self setNeedsLayout];
    }
}

- (void)setMessage:(NSString *)message
{
    if (![_message isEqualToString:message])
    {
        _message = message;
        _messageLabel.text = message;
        [self setNeedsLayout];
    }
}

- (void)setInsets:(UIEdgeInsets)insets
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_insets, insets)) {
        _insets = insets;
        [self setNeedsLayout];
    }
}

- (void)setTitleLabelFont:(UIFont *)titleLabelFont
{
    _titleLabel.font = titleLabelFont;
    [self setNeedsLayout];
}

- (UIFont *)titleLabelFont
{
    return _titleLabel.font;
}

- (void)setMessageLabelFont:(UIFont *)messageLabelFont
{
    _messageLabel.font = messageLabelFont;
    [self setNeedsLayout];
}

- (UIFont *)messageLabelFont
{
    return _messageLabel.font;
}

- (void)setTitleLabelColor:(UIColor *)titleLabelColor
{
    _titleLabel.textColor = titleLabelColor;
}

- (UIColor *)titleLabelColor
{
    return _titleLabel.textColor;
}

- (void)setMessageLabelColor:(UIColor *)messageLabelColor
{
    _messageLabel.textColor = messageLabelColor;
}

- (UIColor *)messageLabelColor
{
    return _messageLabel.textColor;
}

- (CGFloat)internalSpace
{
    return KBMenuSheethHeaderItemViewInternalSpace;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width screenHeight:(CGFloat)screenHeight
{
    CGFloat height = 0;
    
    if (_title) {
        height += [_titleLabel textRectForBounds:CGRectMake(0, 0, width - self.insets.left - self.insets.right, FLT_MAX) limitedToNumberOfLines:0].size.height;
    }
    
    if (_message) {
        height += [_messageLabel textRectForBounds:CGRectMake(0, 0, width - self.insets.left - self.insets.right, FLT_MAX) limitedToNumberOfLines:0].size.height;
    }
    
    if (_title || _message) {
        height += self.insets.top + self.insets.bottom;
    }
    
    if (_title && _message) {
        height += self.internalSpace;
    }
    
    return height;
}

- (void)layoutSubviews
{
    CGSize size = self.bounds.size;
    CGFloat width = size.width - self.insets.left - self.insets.right;
    
    CGFloat contentHeight = self.insets.top;
    
    if (_title)
    {
        _titleLabel.hidden = NO;
        CGFloat height = [_titleLabel textRectForBounds:CGRectMake(0, 0, width, FLT_MAX) limitedToNumberOfLines:0].size.height;
        _titleLabel.frame = CGRectMake(self.insets.left, contentHeight, width, height);
        
        contentHeight += height;
    } else {
        _titleLabel.hidden = YES;
    }
        
    if (_message)
    {
        if (_title)
            contentHeight += self.internalSpace;

        _messageLabel.hidden = NO;
        CGFloat height = [_messageLabel textRectForBounds:CGRectMake(0, 0, width, FLT_MAX) limitedToNumberOfLines:0].size.height;
        _messageLabel.frame = CGRectMake(self.insets.left, contentHeight, width, height);
    } else {
        _messageLabel.hidden = YES;
    }
    
    if (self.layoutUpdateBlock) {
        self.layoutUpdateBlock();
    }
}

@end
