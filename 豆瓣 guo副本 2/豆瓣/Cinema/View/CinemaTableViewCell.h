//
//  CinemaTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cinema.h"

@interface CinemaTableViewCell : UITableViewCell

@property (nonatomic, retain) UILabel *cinemaNameLabel;
@property (nonatomic, retain) UILabel *addressLabel;
@property (nonatomic, retain) UILabel *telephoneLabel;

@property (nonatomic, retain) Cinema *cinema;
@end
