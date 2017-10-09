//
//  KBGenderPickerController.h
//  KBMenuSheet
//
//  Created by 肖雄 on 17/7/17.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol KBGenderPickerControllerDelegate;
@interface KBGenderPickerController : UIViewController

@property (nonatomic, copy) void(^finishHandle)(NSString *gender);
@property (nonatomic, copy) void(^cancelHandle)();

@property (nonatomic, weak) id<KBGenderPickerControllerDelegate>delegate;

@end

@protocol KBGenderPickerControllerDelegate <NSObject>
@optional
- (void)genderPickerControllerDidCancel:(KBGenderPickerController *)picker;
- (void)genderPickerController:(KBGenderPickerController *)picker didFinishedWithGender:(NSString *)gender;

@end
