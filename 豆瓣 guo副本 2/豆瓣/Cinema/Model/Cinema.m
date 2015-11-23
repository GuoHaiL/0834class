//
//  Cinema.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "Cinema.h"

@implementation Cinema

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@",_cinemaName];
}

@end
