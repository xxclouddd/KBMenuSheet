//
//  KBMenuSheetHeaderItemView.h
//  test5
//
//  Created by 肖雄 on 16/11/3.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetItemView.h"

@interface KBMenuSheetHeaderItemView : KBMenuSheetItemView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) UIFont *titleLabelFont;
@property (nonatomic, strong) UIFont *messageLabelFont;

@property (nonatomic, strong) UIColor *titleLabelColor;
@property (nonatomic, strong) UIColor *messageLabelColor;

@property (nonatomic, assign) UIEdgeInsets insets;
@property (nonatomic, readonly) CGFloat internalSpace;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message;

@end
