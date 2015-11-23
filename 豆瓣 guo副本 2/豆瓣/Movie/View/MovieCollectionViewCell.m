//
//  MovieCollectionViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieCollectionViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation MovieCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        
        UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth/3 - 25, 150)];
        //UIView *bigView = [[UIView alloc]initWithFrame:frame];
        bigView.backgroundColor = [UIColor blackColor];
        self.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kWidth/3 - 25, 120)];
        _pictureView.backgroundColor = [UIColor redColor];
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 130, kWidth/3 - 25, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _titleLabel.backgroundColor = [UIColor whiteColor];
        
        [bigView addSubview:_pictureView];
        [bigView addSubview:_titleLabel];
        
        [self addSubview:bigView];
    }
    return self;
}

- (void)setMovie:(Movie *)movie{
    _titleLabel.text = movie.movieName;
}

@end
