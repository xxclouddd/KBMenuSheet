//
//  KBMenuSheetPresentationController.m
//  test5
//
//  Created by 肖雄 on 16/11/4.
//  Copyright © 2016年 kuaibao. All rights reserved.
//

#import "KBMenuSheetPresentationController.h"

@interface KBMenuSheetPresentationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong, readwrite) KBDimmingBackdropView *dimmingView;

@end

@implementation KBMenuSheetPresentationController

- (void)presentationTransitionWillBegin
{
    self.dimmingView.frame = self.containerView.bounds;
    self.dimmingView.alpha = 0.0;
    [self.containerView addSubview:self.dimmingView];

    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
    {
        [UIView animateWithDuration:[context transitionDuration] animations:^
        {
            self.dimmingView.alpha = 1.0;
        }];
    } completion:nil];
    
    [super presentationTransitionWillBegin];
}

- (void)presentationTransitionDidEnd:(BOOL)completed
{
    if (!completed) {
        [self.dimmingView removeFromSuperview];
    }
    
    [super presentationTransitionDidEnd:completed];
}

- (void)dismissalTransitionWillBegin
{
    [self.presentedViewController.transitionCoordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context)
    {
        [UIView animateWithDuration:[context transitionDuration] animations:^
        {
            self.dimmingView.alpha = 0.0;
        }];
    } completion:nil];

    [super dismissalTransitionWillBegin];
}

- (void)dismissalTransitionDidEnd:(BOOL)completed
{
    if (completed) {
        [self.dimmingView removeFromSuperview];
    }
    
    [super dismissalTransitionDidEnd:completed];
}

/*
- (UIModalPresentationStyle)presentationStyle
{
    return UIModalPresentationFormSheet;
}

- (UIModalPresentationStyle)adaptivePresentationStyle
{
    return UIModalPresentationFormSheet;
}
*/
 
- (CGRect)frameOfPresentedViewInContainerView
{
    CGSize presentedContentSize = self.presentedViewController.preferredContentSize;
    CGSize containerSize = self.containerView.bounds.size;
    return CGRectMake(fabs((containerSize.width - presentedContentSize.width) / 2.0), containerSize.height - presentedContentSize.height, presentedContentSize.width, presentedContentSize.height);
}

- (BOOL)shouldRemovePresentersView
{
    return NO;
}

- (void)containerViewWillLayoutSubviews
{
    [super containerViewWillLayoutSubviews];
}

- (void)containerViewDidLayoutSubviews
{
    [super containerViewDidLayoutSubviews];
    
    /*
    CGSize preferredSize = self.presentedViewController.preferredContentSize;
    UIView *presentedView = [self.presentedViewController view];
    CGSize trulySize = presentedView.frame.size;
    
    if (!CGSizeEqualToSize(preferredSize, trulySize)) {
        [self relayoutContainerViewWithAnimate:NO];
    }
     */
}

- (BOOL)shouldPresentInFullscreen
{
    return NO;
}

- (void)relayoutContainerViewWithAnimate:(BOOL)animate
{
    CGSize containerSize = self.containerView.bounds.size;
    
    UIView *presentedView = [self.presentedViewController view];
    CGRect presentedViewFrame = presentedView.frame;
    CGSize presentedContentSize = self.presentedViewController.preferredContentSize;
    
    presentedViewFrame.size.height = self.presentedViewController.preferredContentSize.height;
    presentedViewFrame.origin.y = containerSize.height - presentedContentSize.height;
    presentedViewFrame.size.width = fabs((containerSize.width - presentedContentSize.width) / 2.0);
    
    if (animate) {
        [UIView animateWithDuration:0.2 animations:^{
            presentedView.frame = presentedViewFrame;
        }];
    } else {
        presentedView.frame = presentedViewFrame;
        self.containerView.userInteractionEnabled = YES;
    }
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (touch.view == self.dimmingView) {
        return YES;
    }
    return NO;
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)tapGesture
{
    if (tapGesture.state == UIGestureRecognizerStateEnded)
    {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - setter and getter
- (KBDimmingBackdropView *)dimmingView
{
    if (!_dimmingView) {
        _dimmingView = [[KBDimmingBackdropView alloc] init];
        _dimmingView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
        tapGesture.delegate = self;
        [_dimmingView addGestureRecognizer:tapGesture];
    }
    return _dimmingView;
}

@end
