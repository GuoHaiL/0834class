//
//  MovieTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

@interface MovieTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *pictureView;
@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) Movie *movie;

@end
