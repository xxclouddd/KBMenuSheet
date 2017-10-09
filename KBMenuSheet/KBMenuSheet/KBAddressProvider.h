//
//  KBAddressProvider.h
//  KBMenuSheet
//
//  Created by 肖雄 on 17/5/26.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KBAddress.h"

@interface KBAddressProvider : NSObject

- (NSArray <KBAddress *> *)fetchAllPrivinces;
- (NSArray <KBAddress *> *)fetchCitiesWithPid:(NSInteger)pid;
- (NSArray <KBAddress *> *)fetchDistrictsWithPid:(NSInteger)pid;

@end
