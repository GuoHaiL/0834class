//
//  DetailsTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Activity.h"

@interface DetailsTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *timeLabel;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UILabel *typeLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UIImageView *pictureView;
@property (nonatomic, retain) UILabel *contentLabel;

@property (nonatomic, retain) Activity *activity;

@end
