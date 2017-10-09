//
//  KBAddressProvider.m
//  KBMenuSheet
//
//  Created by 肖雄 on 17/5/26.
//  Copyright © 2017年 kuaibao. All rights reserved.
//

#import "KBAddressProvider.h"
#import <FMDB/FMDB.h>

@interface KBAddressProvider ()
{
    FMDatabase *_db;
}

@end


@implementation KBAddressProvider

- (instancetype)init
{
    if ((self = [super init]) == nil) return nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"db"];
    
    _db = [[FMDatabase alloc] initWithPath:path];
    BOOL open = [_db open];
    if (!open) {
        return nil;
    }
    
    return self;
}

- (void)dealloc
{
    [_db close];
}

- (NSArray <KBAddress *> *)fetchAllPrivinces
{
    NSMutableArray *container = [NSMutableArray array];
    
    FMResultSet *results = [_db executeQuery:@"select * from tbl_area where level = 1"];
    while ([results next]) {
        KBAddress *model = [[KBAddress alloc] init];
        model.id = [results intForColumn:@"id"];
        model.pid = [results intForColumn:@"pid"];
        model.level = [results intForColumn:@"level"];
        model.name = [results stringForColumn:@"name"];
        model.names = [results stringForColumn:@"names"];
        model.shortPinYin = [results stringForColumn:@"short_pinyin"];
        [container addObject:model];
    }
    
    return container;
}

- (NSArray <KBAddress *> *)fetchCitiesWithPid:(NSInteger)pid
{
    NSMutableArray *container = [NSMutableArray array];
    
    FMResultSet *results = [_db executeQuery:@"select * from tbl_area where pid = ?", @(pid)];
    while ([results next]) {
        KBAddress *model = [[KBAddress alloc] init];
        model.id = [results intForColumn:@"id"];
        model.pid = [results intForColumn:@"pid"];
        model.level = [results intForColumn:@"level"];
        model.name = [results stringForColumn:@"name"];
        model.names = [results stringForColumn:@"names"];
        model.shortPinYin = [results stringForColumn:@"short_pinyin"];
        [container addObject:model];
    }
    
    return container;
}

- (NSArray <KBAddress *> *)fetchDistrictsWithPid:(NSInteger)pid
{
    NSMutableArray *container = [NSMutableArray array];
    
    FMResultSet *results = [_db executeQuery:@"select * from tbl_area where pid = ?", @(pid)];
    while ([results next]) {
        KBAddress *model = [[KBAddress alloc] init];
        model.id = [results intForColumn:@"id"];
        model.pid = [results intForColumn:@"pid"];
        model.level = [results intForColumn:@"level"];
        model.name = [results stringForColumn:@"name"];
        model.names = [results stringForColumn:@"names"];
        model.shortPinYin = [results stringForColumn:@"short_pinyin"];
        [container addObject:model];
    }
    
    return container;
}


@end
