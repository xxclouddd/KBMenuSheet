//
//  KBInterfaceActionGroupView.h
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, KBInterfaceActionGroupViewType) {
    KBInterfaceActionGroupViewTypeDefault,
    KBInterfaceActionGroupViewTypeHeader
};

@interface KBInterfaceActionGroupView : UIView

@property (nonatomic, readonly) KBInterfaceActionGroupViewType type;
- (instancetype)initWithType:(KBInterfaceActionGroupViewType)type;

@property (nonatomic, copy) void (^layoutUpdateBlock)(void);
- (void)requestMenuLayoutUpdate;

@property (nonatomic, assign) CGFloat preferredWidth;
@property (nonatomic, readonly) CGFloat preferredHeight;
@property (nonatomic, readonly) CGSize preferredSize;

@end
