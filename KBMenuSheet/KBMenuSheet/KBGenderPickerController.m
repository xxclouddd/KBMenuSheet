//
//  KBGenderPickerController.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/7/17.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "KBGenderPickerController.h"
#import "KBMenuSheetPresentationController.h"

@interface KBGenderPickerController ()<UIViewControllerTransitioningDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) NSArray *genders;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation KBGenderPickerController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];

    _genders = @[@"男", @"女"];
    
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelHandle:)];
    cancelItem.tintColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1.0];
    
    UIBarButtonItem *confirItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmHandle:)];
    confirItem.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    _toolBar = [[UIToolbar alloc] init];
    _toolBar.items = @[cancelItem, flexSpace, confirItem];
    _toolBar.frame = CGRectMake(0, 0, self.view.frame.size.width, 44);
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_toolBar];
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, self.view.frame.size.width, self.view.frame.size.height - 44)];
    _pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.showsSelectionIndicator = YES;
    [self.view addSubview:_pickerView];
}

- (CGSize)preferredContentSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 230);
}

#pragma mark - response
- (void)cancelHandle:(id)sender
{
    if (self.cancelHandle) {
        self.cancelHandle();
    }
    
    if ([self.delegate respondsToSelector:@selector(genderPickerControllerDidCancel:)]) {
        [self.delegate genderPickerControllerDidCancel:self];
    }
}

- (void)confirmHandle:(id)sender
{
    NSInteger index = [self.pickerView selectedRowInComponent:0];
    NSString *gender = _genders[index];
    
    if (self.finishHandle) {
        self.finishHandle(gender);
    }
    
    if ([self.delegate respondsToSelector:@selector(genderPickerController:didFinishedWithGender:)]) {
        [self.delegate genderPickerController:self didFinishedWithGender:gender];
    }
}

#pragma mark - UIPickerViewDataSource && dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _genders.count;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 34;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _genders[row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[KBMenuSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}



@end
