//
//  KBMenuSheetPresentationController.h
//  test5
//
//  Created by 肖雄 on 16/11/4.
//  Copyright © 2016年 xiaoxiong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBDimmingBackdropView.h"

@interface KBMenuSheetPresentationController : UIPresentationController

@property (nonatomic, strong, readonly) KBDimmingBackdropView *dimmingView;

@end
