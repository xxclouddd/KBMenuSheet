//
//  KBActivityViewController.m
//  test5
//
//  Created by 肖雄 on 16/11/18.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBActivityViewController.h"
#import "KBMenuSheetView.h"
#import "KBMenuSheetPresentationController.h"
#import "KBMenuSheetControllerInterfaceActionGroupView.h"
#import "KBMeunSheetActivityActionSequenceView.h"
#import "KBMenuSheetButtonItemView.h"

@interface KBActivityViewController ()<UIViewControllerTransitioningDelegate>
{
    KBMenuSheetView *_activityView;
    KBMenuSheetItemView *_headerItem;
    
    NSArray *_activityItems;
    NSArray *_activityItemViews;
}

@end

@implementation KBActivityViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }
    return self;
}

- (instancetype)initWithActivityItems:(NSArray *)activityItems activities:(NSArray<__kindof KBActivityItemView *> *)activities headerItem:(KBMenuSheetItemView *)headerItem
{
    self = [super init];
    if ([self init])
    {
        _activityItems = activityItems;
        _activityItemViews = activities;
        if (_activityItemViews == nil)
            _activityItemViews = [self availableActivityItem];
        _headerItem = headerItem;
    }
    return self;
}

- (instancetype)initWithActivityItems:(NSArray *)activityItems activities:(NSArray<KBActivityItemView *> *)activities
{
    return [self initWithActivityItems:activityItems activities:activities headerItem:nil];
}

- (void)loadView
{
    [super loadView];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (_activityView && ![_activityView isDescendantOfView:self.view])
        [self.view addSubview:_activityView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setItemViews:_activityItemViews];
}

- (void)viewWillLayoutSubviews
{    
    CGSize menuSize = _activityView.menuSize;
    _activityView.frame = CGRectMake(0, 0, menuSize.width, menuSize.height);
}

- (void)setItemViews:(NSArray<KBActivityItemView *> *)itemViews;
{
    NSMutableArray *views = [NSMutableArray array];
    KBMeunSheetActivityActionSequenceView *firstLevelView = nil;
    KBMeunSheetActivityActionSequenceView *secondLevelView = nil;
   
    for (id obj in itemViews)
    {
        KBActivityItemView *item = nil;
        if ([obj isKindOfClass:[KBActivityItemView class]])
        {
            item = (KBActivityItemView *)obj;
        }
        else if ([obj isKindOfClass:[NSString class]])
        {
            BOOL includeException = NO;
            for (NSString *type in self.excludedActivityTypes) {
                includeException = [obj isEqualToString:type];
                if (includeException) break;
            }
            
            if (includeException) continue;
            
            NSString *className = [NSString stringWithFormat:@"KBActivityItem%@View", (NSString *)obj];
            Class class = NSClassFromString(className);
            
            if (class) {
                item = (KBActivityItemView *)[[class alloc] init];
            }
        }
        if (![item canPerformWithActivityItems:_activityItems]) continue;
        
        if (item.activityCategory == KBActivityItemViewCategoryValue1)
        {
            if (firstLevelView == nil)
                firstLevelView = [[KBMeunSheetActivityActionSequenceView alloc] initWithActivityItemViews:nil];
            [firstLevelView addItems:@[item]];
        }
        else if (item.activityCategory == KBActivityItemViewCategoryValue2)
        {
            if (secondLevelView == nil)
                secondLevelView = [[KBMeunSheetActivityActionSequenceView alloc] initWithActivityItemViews:nil];
            [secondLevelView addItems:@[item]];
        }
        
        void(^didSelectHandle)() = ^
        {
            if (item.dismissAutomatically) {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        };
        
        void(^willSelectedHandle)() = ^
        {
            [item prepareWithActivityItems:_activityItems];
        };

        void(^didFinishHandle)(NSError *error) = ^(NSError *error)
        {
            [self activityDidFinish:error];
        };
        
        item.didSelectHandle = didSelectHandle;
        item.willSelectHandle = willSelectedHandle;
        item.didFinishHandle = didFinishHandle;
        item.activityViewController = self.presentingViewController;
    }
    
    if (_headerItem)
        [views addObject:_headerItem];
    
    if (firstLevelView)
        [views addObject:firstLevelView];
    
    if (secondLevelView)
        [views addObject:secondLevelView];
    
    KBMeunSheetActivityActionSequenceView *lastSequenceView = [views lastObject];
    
    
    __weak typeof (self)weakSelf = self;
    KBMenuSheetButtonItemView *cancelItem = [[KBMenuSheetButtonItemView alloc] initWithTitle:@"取消" type:KBMenuSheetButtonTypeDefault action:^
    {
        __strong typeof (self)strongSelf = weakSelf;
        [strongSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    cancelItem.backgroundColor = [UIColor whiteColor];
    [views addObject:cancelItem];

    
    KBMenuSheetControllerInterfaceActionGroupView *groupView =  [[KBMenuSheetControllerInterfaceActionGroupView alloc] initWithItemViews:views];
    groupView.layer.cornerRadius = 0;

    _activityView = [[KBMenuSheetView alloc] initWithGroupViews:@[groupView]];
    _activityView.menuWidth = [UIScreen mainScreen].bounds.size.width;
    _activityView.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    if (_headerItem)
        _headerItem.dividerView.backgroundColor = [UIColor clearColor];
    
    if (lastSequenceView)
        lastSequenceView.dividerView.backgroundColor = [UIColor clearColor];
    
    if (self.isViewLoaded)
        [self.view addSubview:_activityView];
}

- (CGSize)preferredContentSize
{
    return _activityView.menuSize;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)availableActivityItem
{
    return @[KBActivityTypePostToWeChatMoment,
             KBActivityTypePostToWeChat,
             KBActivityTypePostToQQ,
             KBActivityTypePostToQQZone,
             KBActivityTypePostToWeibo,
             KBActivityTypeMail,
             KBActivityTypeMessage,
             KBActivityTypeCopyToPasteboard];
}

#pragma mark - action
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)activityDidFinish:(NSError *)error
{
    if (self.didFinishHandle) {
        self.didFinishHandle(error);
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source
{
    return [[KBMenuSheetPresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

@end
