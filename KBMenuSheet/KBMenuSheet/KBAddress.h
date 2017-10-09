//
//  KBAddress.h
//  KBMenuSheet
//
//  Created by 肖雄 on 17/5/26.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KBAddress : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger pid;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *names;
@property (nonatomic, strong) NSString *shortPinYin;
@property (nonatomic, assign) NSInteger level;

@end
