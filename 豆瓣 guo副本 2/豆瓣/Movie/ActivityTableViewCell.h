//
//  ActivityTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface ActivityTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UILabel *typeLabel;
@property (nonatomic, retain) UILabel *interestLabel;
@property (nonatomic, retain) UILabel *joinLabel;
@property (nonatomic, retain) NSString *imageStr;
@property (nonatomic, retain) UIImageView *pictureView;

@property (nonatomic, retain) Activity *activity;
@end
