//
//  MovieTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieTableViewCell.h"

@implementation MovieTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_eventlistcell"]];
        backgroundImageView.frame = CGRectMake(0, 0, 355, 160);
        self.backgroundView = backgroundImageView;
        
        self.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 100, 150)];
//        _pictureView.backgroundColor = [UIColor redColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(120, 60, 250, 50)];
//        _titleLabel.backgroundColor = [UIColor redColor];
        _titleLabel.font = [UIFont systemFontOfSize:25];
        [self addSubview:_pictureView];
        [self addSubview:_titleLabel];
        
    }
    return self;
}

- (void)setMovie:(Movie *)movie{
    _titleLabel.text = movie.movieName;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
