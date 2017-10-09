//
//  KBActivityItemView.m
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBActivityItemView.h"

KBActivityType const KBActivityTypePostToWeChatMoment  = @"WeChatMoment";
KBActivityType const KBActivityTypePostToWeChat        = @"WeChat";
KBActivityType const KBActivityTypePostToQQ            = @"QQ";
KBActivityType const KBActivityTypePostToQQZone        = @"QQZone";
KBActivityType const KBActivityTypePostToWeibo         = @"Weibo";
KBActivityType const KBActivityTypeMail                = @"Mail";
KBActivityType const KBActivityTypeMessage             = @"Message";
KBActivityType const KBActivityTypeCopyToPasteboard    = @"CopyToPasteboard";

@interface KBActivityItemView ()
{
    UIButton *_actionBtn;
    UILabel *_titleLabel;
}

@end

@implementation KBActivityItemView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _dismissAutomatically = YES;
        
        [self _setupSubview];
    }
    return self;
}

- (KBActivityType)activityType
{
    return @"";
}

- (KBActivityItemViewCategory)activityCategory
{
    return KBActivityItemViewCategoryValue1;
}

- (void)_setupSubview
{
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_actionBtn setImage:self.image forState:UIControlStateNormal];
    [_actionBtn addTarget:self action:@selector(activity:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_actionBtn];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = [UIFont systemFontOfSize:11];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.text = self.title;
    [self addSubview:_titleLabel];        
}

- (void)activity:(id)sender
{
    if (self.willSelectHandle) {
        self.willSelectHandle();
    }
    
    if (self.didSelectHandle) {
        self.didSelectHandle();
    }
    
    [self performActivity];
}

- (CGSize)sizeThatFits:(CGSize)size
{
    CGFloat height = 60 + 7;
    height += [self.title boundingRectWithSize:CGSizeMake(70, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: _titleLabel.font} context:NULL].size.height;
    height = ceil(height);
    
    return CGSizeMake(64, height);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _actionBtn.frame = CGRectMake(2, 0, 60, 60);
    _titleLabel.frame = CGRectMake(0, 67, self.bounds.size.width, self.bounds.size.height - 67);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
   
}

- (void)performActivity
{
    [self activityDidFinish:nil];
}

- (void)activityDidFinish:(NSError *)error
{
    if (self.didFinishHandle) {
        self.didFinishHandle(error);
    }
}

@end
