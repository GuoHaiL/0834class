//
//  Activity.h
//  豆瓣
//
//  Created by lanou3g on 15/10/21.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Owner.h"

@interface Activity : NSObject

@property (nonatomic, retain) NSString *subcategory_name;
@property (nonatomic, retain) NSString *begin_time;
@property (nonatomic, retain) NSString *image;
@property (nonatomic, retain) NSString *adapt_url;
@property (nonatomic, retain) Owner *owner;
@property (nonatomic, retain) NSString *loc_name;
@property (nonatomic, retain) NSString *alt;
@property (nonatomic, retain) NSString *ID;
@property (nonatomic, retain) NSString *category;
@property (nonatomic, retain) NSString *title;

@property (nonatomic, assign) NSInteger wisher_count;
@property (nonatomic, assign) BOOL has_ticket;

@property (nonatomic, retain) NSString *content;
@property (nonatomic, retain) NSString *can_invite;
@property (nonatomic, retain) NSString *album;

@property (nonatomic, assign) NSInteger participant_count;

@property (nonatomic, retain) NSString *image_hlarge;
@property (nonatomic, retain) NSArray *photosArray;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *geo;
@property (nonatomic, retain) NSString *image_lmobile;
@property (nonatomic, retain) NSString *category_name;
@property (nonatomic, retain) NSString *loc_id;
@property (nonatomic, retain) NSString *end_time;




@end
