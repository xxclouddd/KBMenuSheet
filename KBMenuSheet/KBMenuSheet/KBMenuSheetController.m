//
//  KBMenuSheetController.m
//  test5
//
//  Created by 肖雄 on 16/11/2.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetController.h"
#import "KBMenuSheetPresentationController.h"
#import "KBCustomMenuSheetView.h"

@interface KBMenuSheetController ()<UIViewControllerTransitioningDelegate>
{
    KBCustomMenuSheetView *_sheetView;
}

@end

@implementation KBMenuSheetController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (instancetype)initWithItemViews:(NSArray<KBMenuSheetItemView *> *)itemViews
{
    self = [self init];
    if (self) {
        [self setItemViews:itemViews animated:false];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message defaultCancel:(BOOL)cancel itemViews:(NSArray<KBMenuSheetItemView *> *)itemViews
{
    NSMutableArray *items = [NSMutableArray array];
    if (itemViews.count > 0) {
        [items addObjectsFromArray:itemViews];
    }
    
    if (title || message)
    {
        KBMenuSheetHeaderItemView *header = [[KBMenuSheetHeaderItemView alloc] initWithTitle:title message:message];
        [items insertObject:header atIndex:0];
    }
    
    if (cancel)
    {
        __weak typeof (self)weakSelf = self;
        KBMenuSheetButtonItemView *cancelItem = [[KBMenuSheetButtonItemView alloc] initWithTitle:@"取消" type:KBMenuSheetButtonTypeCancel action:^
        {
            __strong typeof (self)strongSelf = weakSelf;
            [strongSelf dismissViewControllerAnimated:YES completion:nil];
        }];
        [items addObject:cancelItem];
    }
    
    self = [self initWithItemViews:items];
    if (self)
    {
        for (KBMenuSheetItemView *itemView in itemViews) {
            if ([itemView isKindOfClass:[KBMenuSheetButtonItemView class]])
                [(KBMenuSheetButtonItemView *)itemView setMenuSheetController:self];
        }
    }
    
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message itemViews:(NSArray<KBMenuSheetItemView *> *)itemViews
{
    return [self initWithTitle:title message:message defaultCancel:YES itemViews:itemViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (_sheetView && ![_sheetView isDescendantOfView:self.view])
        [self.view addSubview:_sheetView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setItemViews:(NSArray<KBMenuSheetItemView *> *)itemViews animated:(bool)animated
{
    _sheetView = [[KBCustomMenuSheetView alloc] initWithItemViews:itemViews];
    _sheetView.menuWidth = [UIScreen mainScreen].bounds.size.width;
    _sheetView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    _sheetView.interSectionSpacing = 5;
    _sheetView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    // adjust seperate line in main section.
    KBMenuSheetItemView *lastItem = [[_sheetView.mainView items] lastObject];
    lastItem.dividerView.backgroundColor = [UIColor clearColor];
    
    if (self.isViewLoaded)
        [self.view addSubview:_sheetView];
    
    [self.view setNeedsLayout];
}

- (CGSize)preferredContentSize
{
    return _sheetView.menuSize;
}

#pragma mark -
- (void)viewWillLayoutSubviews
{
    /*
    __weak KBMenuSheetController *weakSelf = self;
    void (^menuRelayout)(void) = ^
    {
        __strong KBMenuSheetController *strongSelf = weakSelf;
        if (strongSelf == nil)
            return;
        [self.presentationController.containerView setNeedsLayout];
    };
     */
    
    CGSize menuSize = _sheetView.menuSize;
    _sheetView.frame = CGRectMake(0, 0, menuSize.width, menuSize.height);
//    _sheetView.menuRelayout = menuRelayout;
}

#pragma mark - rotation
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    
    
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[KBMenuSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];    
}


@end
