//
//  Owner.m
//  豆瓣
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "Owner.h"

@implementation Owner

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@",_name];
}

@end
