//
//  KBMenuSheetItemView.m
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBMenuSheetItemView.h"

@implementation KBMenuSheetItemView


- (instancetype)initWithType:(KBMenuSheetItemType)type
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _type = type;
    }
    return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)__unused width screenHeight:(CGFloat)__unused screenHeight
{
    return 0;
}

- (void)requestMenuLayoutUpdate
{
    if (self.layoutUpdateBlock != nil)
        self.layoutUpdateBlock();
}

- (void)menuView:(KBMenuSheetView *)menuView willAppearAnimated:(BOOL)animated
{

}

- (void)menuView:(KBMenuSheetView *)menuView didAppearAnimated:(BOOL)animated
{

}

- (void)menuView:(KBMenuSheetView *)menuView willDisappearAnimated:(BOOL)animated
{

}

- (void)menuView:(KBMenuSheetView *)menuView didDisappearAnimated:(BOOL)animated
{

}

@end
