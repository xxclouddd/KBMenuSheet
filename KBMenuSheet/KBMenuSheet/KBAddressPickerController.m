//
//  KBAddressPickerController.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/5/25.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBAddressPickerController.h"
#import "KBMenuSheetPresentationController.h"
#import <FMDB/FMDB.h>

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

NSString * const KBAddressPickerInfoProvinceKey = @"province";
NSString * const KBAddressPickerInfoCityKey     = @"city";
NSString * const KBAddressPickerInfoDistrictKey = @"district";

@interface KBAddressPickerController ()<UIViewControllerTransitioningDelegate, UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) KBAddressProvider *dataProvider;
@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NSArray *districts;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *toolBar;

@end

@implementation KBAddressPickerController

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
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataProvider = [[KBAddressProvider alloc] init];
    
    _provinces = [_dataProvider fetchAllPrivinces];
    
    KBAddress *provinceModel = [_provinces firstObject];
    _cities = [_dataProvider fetchCitiesWithPid:provinceModel.id];
    
    KBAddress *cityModel = [_cities firstObject];
    _districts = [_dataProvider fetchDistrictsWithPid:cityModel.id];
    
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
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 250);
}

#pragma mark - response 
- (void)cancelHandle:(id)sender
{
    if (self.cancelHandle) {
        self.cancelHandle();
    }
    
    if ([self.delegate respondsToSelector:@selector(addressPickerControllerDidCancel:)]) {
        [self.delegate addressPickerControllerDidCancel:self];
    }
}

- (void)confirmHandle:(id)sender
{
    NSInteger provinceIndex = [self.pickerView selectedRowInComponent:PROVINCE_COMPONENT];
    NSInteger cityIndex = [self.pickerView selectedRowInComponent:CITY_COMPONENT];
    NSInteger districtIndex = [self.pickerView selectedRowInComponent:DISTRICT_COMPONENT];
    
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    
    if (_provinces.count > provinceIndex) {
        KBAddress *provice = _provinces[provinceIndex];
        [info setObject:provice forKey:KBAddressPickerInfoProvinceKey];
    }
    
    if (_cities.count > cityIndex) {
        KBAddress *city = _cities[cityIndex];
        [info setObject:city forKey:KBAddressPickerInfoCityKey];
    }
    
    if (_districts.count > districtIndex) {
        KBAddress *district = _districts[districtIndex];
        [info setObject:district forKey:KBAddressPickerInfoDistrictKey];
    }
    
    if (self.finishHandle) {
        self.finishHandle(info);
    }
    
    if ([self.delegate respondsToSelector:@selector(addressPickerController:didFinishedWithInfo:)]) {
        [self.delegate addressPickerController:self didFinishedWithInfo:info];
    }
}

/*
- (NSInteger)indexForProvince:(NSString *)province;
{
    if (province == nil) {
        return NSNotFound;
    }
    
    return [_provinces indexOfObjectPassingTest:^BOOL(KBAddress *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.name isEqualToString:province];
   }];
}

- (NSInteger)indexForCity:(NSString *)city
{
    if (city == nil) {
        return NSNotFound;
    }

    return [_cities indexOfObjectPassingTest:^BOOL(KBAddress *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.name isEqualToString:city];
    }];
}

- (NSInteger)indexForDistrict:(NSString *)district
{
    if (district == nil) {
        return NSNotFound;
    }
    
    return [_districts indexOfObjectPassingTest:^BOOL(KBAddress *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [obj.name isEqualToString:district];
    }];
}
 */

#pragma mark - UIPickerViewDataSource && dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return self.provinces.count;
    } else if (component == CITY_COMPONENT) {
        return self.cities.count;
    } else {
        return self.districts.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 34;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        KBAddress *model = self.provinces[row];
        return model.name;
    } else if (component == CITY_COMPONENT) {
        KBAddress *model = self.cities[row];
        return model.name;
    } else {
        KBAddress *model = self.districts[row];
        return model.name;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        KBAddress *provinceModel = self.provinces[row];
        self.cities = [self.dataProvider fetchCitiesWithPid:provinceModel.id];
        
        KBAddress *cityModel = [self.cities firstObject];
        self.districts = [self.dataProvider fetchDistrictsWithPid:cityModel.id];
        
        [pickerView selectRow:0 inComponent:CITY_COMPONENT animated:YES];
        [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        [pickerView reloadComponent:CITY_COMPONENT];
        [pickerView reloadComponent:DISTRICT_COMPONENT];
    } else if (component == CITY_COMPONENT){
        KBAddress *cityModel = self.cities[row];
        self.districts = [self.dataProvider fetchDistrictsWithPid:cityModel.id];
        
        [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        [pickerView reloadComponent:DISTRICT_COMPONENT];
    }
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





