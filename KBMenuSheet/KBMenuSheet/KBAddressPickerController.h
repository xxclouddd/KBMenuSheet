//
//  KBAddressPickerController.h
//  KBMenuSheet
//
//  Created by 肖雄 on 17/5/25.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KBAddressProvider.h"
@protocol KBAddressPickerControllerDelegate;

extern NSString * const KBAddressPickerInfoProvinceKey;
extern NSString * const KBAddressPickerInfoCityKey;
extern NSString * const KBAddressPickerInfoDistrictKey;

@interface KBAddressPickerController : UIViewController

@property (nonatomic, copy) void(^finishHandle)(NSDictionary *info);
@property (nonatomic, copy) void(^cancelHandle)();

@property (nonatomic, weak) id<KBAddressPickerControllerDelegate>delegate;

@end


@protocol KBAddressPickerControllerDelegate <NSObject>
@optional
- (void)addressPickerControllerDidCancel:(KBAddressPickerController *)picker;
- (void)addressPickerController:(KBAddressPickerController *)picker didFinishedWithInfo:(NSDictionary *)info;

@end
