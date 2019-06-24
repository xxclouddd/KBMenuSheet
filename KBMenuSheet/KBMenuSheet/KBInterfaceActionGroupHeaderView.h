//
//  KBInterfaceActionGroupHeaderView.h
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import "KBInterfaceActionGroupView.h"

@interface KBInterfaceActionGroupHeaderView : KBInterfaceActionGroupView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

@end
