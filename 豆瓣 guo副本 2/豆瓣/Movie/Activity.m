//
//  Activity.m
//  豆瓣
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "Activity.h"

@implementation Activity

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.ID = value;
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"%@, %@",_title,_owner];
}

@end
