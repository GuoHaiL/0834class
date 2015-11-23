//
//  MovieDetailsTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieDetailsTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation MovieDetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.posterView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 100, 140)];
//        _posterView.backgroundColor = [UIColor grayColor];
        
        self.ratingLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 20,kWidth - 160 , 20)];
        _ratingLabel.font = [UIFont systemFontOfSize:17];
        _ratingLabel.textColor = [UIColor darkGrayColor];
//        _ratingLabel.backgroundColor = [UIColor greenColor];
        
        self.release_dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 50, kWidth - 160 , 20)];
        _release_dateLabel.font = [UIFont systemFontOfSize:18];
        _release_dateLabel.textColor = [UIColor darkGrayColor];
//        _release_dateLabel.backgroundColor = [UIColor orangeColor];
        
        self.runtimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 80, kWidth - 160 , 20)];
        _runtimeLabel.font = [UIFont systemFontOfSize:18];
        _runtimeLabel.textColor = [UIColor darkGrayColor];
//        _runtimeLabel.backgroundColor = [UIColor redColor];
        
        self.genresLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 110, kWidth - 160 , 20)];
        _genresLabel.font = [UIFont systemFontOfSize:18];
        _genresLabel.textColor = [UIColor darkGrayColor];
//        _genresLabel.backgroundColor = [UIColor blueColor];
        
        self.countryLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 140, kWidth - 160 , 20)];
        _countryLabel.font = [UIFont systemFontOfSize:18];
        _countryLabel.textColor = [UIColor darkGrayColor];
//        _countryLabel.backgroundColor = [UIColor cyanColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, 150, 40)];
        //label.backgroundColor = [UIColor grayColor];
        label.text = @"制作人";
        label.font = [UIFont systemFontOfSize:25 weight:20];
        
        self.actorsLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 220, kWidth - 15, 50)];
        _actorsLabel.font = [UIFont systemFontOfSize:18];
        _actorsLabel.textColor = [UIColor darkGrayColor];
        _actorsLabel.numberOfLines = 0;
//        _actorsLabel.backgroundColor = [UIColor blackColor];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 280, 150, 40)];
        //label1.backgroundColor = [UIColor grayColor];
        label1.text = @"电影情节";
        label1.font = [UIFont systemFontOfSize:25 weight:20];

        self.plot_simpleLabel = [[UILabel alloc]init];
//        CGRect text = [self.plot_simpleLabel.text boundingRectWithSize:CGSizeMake(355, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
//        _plot_simpleLabel.frame = CGRectMake(10, 330, kWidth-15,text.size.height);
        _plot_simpleLabel.font = [UIFont systemFontOfSize:18];
        _plot_simpleLabel.textColor = [UIColor darkGrayColor];
        _plot_simpleLabel.numberOfLines = 0;
//        _plot_simpleLabel.backgroundColor = [UIColor yellowColor];

        [self addSubview:_posterView];
        [self addSubview:_ratingLabel];
        [self addSubview:_release_dateLabel];
        [self addSubview:_runtimeLabel];
        [self addSubview:_genresLabel];
        [self addSubview:_countryLabel];
        [self addSubview:_actorsLabel];
        [self addSubview:_plot_simpleLabel];
        [self addSubview:label];
        [self addSubview:label1];
        
    }
    return self;
}

- (void)setMovieDetails:(MovieDetails *)movieDetails{
    _ratingLabel.text = [self joint:movieDetails];
    _release_dateLabel.text = movieDetails.release_date;
    _runtimeLabel.text = movieDetails.runtime;
    _genresLabel.text = movieDetails.genres;
    _countryLabel.text = movieDetails.country;
    _actorsLabel.text = movieDetails.actors;
    _plot_simpleLabel.text = movieDetails.plot_simple;
}

#pragma mark 返回一个完整的评论信息
- (NSMutableString *)joint:(MovieDetails *)sender{
    NSMutableString *string = [NSMutableString stringWithFormat:@"评分：%@",sender.rating];
    
    NSMutableString *string1 = [NSMutableString stringWithFormat:@"    (%@评论)",sender.rating_count];
    
    [string appendString:string1];

    return string;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
