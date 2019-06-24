//
//  KBInterfaceActionGroupView.m
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBInterfaceActionGroupView.h"

@implementation KBInterfaceActionGroupView 

- (instancetype)initWithType:(KBInterfaceActionGroupViewType)type
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)requestMenuLayoutUpdate
{
    if (self.layoutUpdateBlock != nil)
        self.layoutUpdateBlock();
}

- (CGSize)preferredSize
{
    return CGSizeMake(self.preferredWidth, self.preferredHeight);
}

@end
