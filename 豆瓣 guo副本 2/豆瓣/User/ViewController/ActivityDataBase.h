//
//  ActivityDataBase.h
//  UI_豆瓣豆瓣
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityDataBase : NSObject<NSCoding>

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * begin_time;
@property (nonatomic, retain) NSString * eng_time;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * category_name;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * countent;




@end
