//
//  ViewController.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/3/2.
//  Copyright © 2017年 xiaoxiong. All rights reserved.
//

#import "ViewController.h"
#import "KBActivityViewController.h"
#import "KBMenuSheetController.h"
#import "KBAddressPickerController.h"
#import "KBGenderPickerController.h"
#import "KBCustomActivityItemMessageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)sheet
{
    /*
    // you can use herit KBMenuSheetItemView to custom whatever you want.
    KBMenuSheetButtonItemView *one = [[KBMenuSheetButtonItemView alloc] initWithTitle:@"one" action:^{
        NSLog(@"one");
    }];
    KBMenuSheetButtonItemView *two = [[KBMenuSheetButtonItemView alloc] initWithTitle:@"two" action:^{
        NSLog(@"tow");
    }];
    KBMenuSheetButtonItemView *three = [[KBMenuSheetButtonItemView alloc] initWithTitle:@"three" action:^{
        NSLog(@"three");
    }];
    
    KBMenuSheetController *sheet = [[KBMenuSheetController alloc] initWithTitle:@"title" message:@"message" itemViews:@[one, two, three]];
    [self presentViewController:sheet animated:YES completion:nil];
     */
    
    
    NSMutableArray *share = [NSMutableArray array];
    NSString *shareTitle = @"title:This is test";
    NSString *shareText = @"content:Time will tell how much I love you";
    //or: NSString *shareText = @"邀你做自由快递员，月入过万！";
    
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    [share addObject:shareTitle];
    [share addObject:shareText];
    [share addObject:url];
    
    KBActivityViewController *con = [[KBActivityViewController alloc] initWithActivityItems:share activities:nil];
    con.excludedActivityTypes = @[KBActivityTypeCopyToPasteboard];
    [self presentViewController:con animated:YES completion:nil];
}

- (void)share
{
    // 使用真机调试
    // 分享的内容支持 url, text, image
    // 如果同时有title和content，"title:"关键字必须加上
    // content默认不用添加关键字 "content:"
    // 不添加关键字默认只有content
    
    NSMutableArray *share = [NSMutableArray array];
    NSString *shareTitle = @"title:This is title";
    NSString *shareText = @"content:邀你做自由快递员，月入过万！";
    //or: NSString *shareText = @"邀你做自由快递员，月入过万！";

    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    [share addObject:shareTitle];
    [share addObject:shareText];
    [share addObject:url];
    
    KBActivityViewController *con = [[KBActivityViewController alloc] initWithActivityItems:share activities:nil];
    [self presentViewController:con animated:YES completion:nil];
    
    con.didFinishHandle = ^(NSError * _Nullable error) {
        NSLog(@"here__");
    };
}

- (IBAction)button1Action:(id)sender
{
    [self sheet];
}

- (IBAction)button2Action:(id)sender
{
    [self share];
}

- (IBAction)button3Acton:(id)sender
{
    KBAddressPickerController *con = [[KBAddressPickerController alloc] init];
    [self presentViewController:con animated:YES completion:nil];
    
    con.cancelHandle = ^{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    };    
}

- (IBAction)button4Action:(id)sender
{
    KBGenderPickerController *con = [[KBGenderPickerController alloc] init];
    [self presentViewController:con animated:YES completion:nil];
    
    con.cancelHandle = ^{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
    
    con.finishHandle = ^(NSString *gender) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    };
}

- (IBAction)customShareItem:(id)sender
{
    NSMutableArray *share = [NSMutableArray array];
    NSString *shareTitle = @"title:This is title";
    NSString *shareText = @"content:邀你做自由快递员，月入过万！";
    //or: NSString *shareText = @"邀你做自由快递员，月入过万！";
    
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    [share addObject:shareTitle];
    [share addObject:shareText];
    [share addObject:url];
    
    KBCustomActivityItemMessageView *customItem = [[KBCustomActivityItemMessageView alloc] init];
    KBMenuSheetHeaderItemView *headerItem = [[KBMenuSheetHeaderItemView alloc] initWithTitle:@"Title" message:@"message"];
    headerItem.backgroundColor = [UIColor whiteColor];
    headerItem.messageLabelColor = [UIColor redColor];
    
    KBActivityViewController *con = [[KBActivityViewController alloc] initWithActivityItems:share activities:@[KBActivityTypePostToWeChat, KBActivityTypePostToQQ, customItem] headerItem:headerItem];
    [self presentViewController:con animated:YES completion:nil];
    
    con.didFinishHandle = ^(NSError * _Nullable error) {
        NSLog(@"call back");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
