//
//  MovieDetailsTableViewCell.h
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetails.h"

@interface MovieDetailsTableViewCell : UITableViewCell

@property (nonatomic, retain) UIImageView *posterView;
@property (nonatomic, retain) UILabel *ratingLabel;
@property (nonatomic, retain) UILabel *release_dateLabel;
@property (nonatomic, retain) UILabel *runtimeLabel;
@property (nonatomic, retain) UILabel *genresLabel;
@property (nonatomic, retain) UILabel *countryLabel;
@property (nonatomic, retain) UILabel *actorsLabel;
@property (nonatomic, retain) UILabel *plot_simpleLabel;

@property (nonatomic, retain) MovieDetails *movieDetails;

@end
