//
//  ActivityDataBase.m
//  UI_豆瓣豆瓣
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "ActivityDataBase.h"
#define kTitle @"title"
#define kImage @"image"
#define kBegin_time @"begin_time"
#define kEng_time @"eng_time"
#define kName @"name"
#define kCategory_name @"category_name"
#define kAddress @"address"
#define kCountent @"countent"

@implementation ActivityDataBase

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    [aCoder encodeObject:self.title forKey:kTitle];
    [aCoder encodeObject:self.image forKey:kImage];
    [aCoder encodeObject:self.begin_time forKey:kBegin_time];
    [aCoder encodeObject:self.eng_time forKey:kEng_time];
    [aCoder encodeObject:self.name forKey:kName];
    [aCoder encodeObject:self.category_name forKey:kCategory_name];
    [aCoder encodeObject:self.address forKey:kAddress];
    [aCoder encodeObject:self.countent forKey:kCountent];
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectForKey:kTitle];
        self.image = [aDecoder decodeObjectForKey:kImage];
        self.begin_time = [aDecoder decodeObjectForKey:kBegin_time];
        self.eng_time = [aDecoder decodeObjectForKey:kEng_time];
        self.name = [aDecoder decodeObjectForKey:kName];
        self.category_name = [aDecoder decodeObjectForKey:kCategory_name];
        self.address = [aDecoder decodeObjectForKey:kAddress];
        self.countent = [aDecoder decodeObjectForKey:kCountent];
    }
    return self;
}



@end
