//
//  KBDimmingBackdropView.m
//  test5
//
//  Created by 肖雄 on 16/12/3.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBDimmingBackdropView.h"

@implementation KBDimmingBackdropView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.passthroughViews.count == 0) {
        return [super hitTest:point withEvent:event];
    }
    
    for (UIView *view in self.passthroughViews)
    {
        UIView *superview = view.superview;
        if (!superview) continue;
        
        CGRect convertRect = [superview convertRect:view.frame toView:self];
        if (!CGRectContainsPoint(convertRect, point)) continue;
        
        CGPoint convertPoint = [self convertPoint:point toView:superview];
        return [superview hitTest:convertPoint withEvent:event];
    }
    
    return [super hitTest:point withEvent:event];
}

@end
