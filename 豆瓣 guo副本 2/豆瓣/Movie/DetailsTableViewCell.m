//
//  DetailsTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "DetailsTableViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation DetailsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, kWidth - 20, 0)];
        _titleLabel.textColor = [UIColor darkGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:20 weight:20];
        _titleLabel.numberOfLines = 0;
        //_titleLabel.backgroundColor = [UIColor blackColor];
        
        self.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 80, 110, 140)];
        //_pictureView.backgroundColor = [UIColor grayColor];
        
        UIImageView *timeView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 80, 20, 20)];
        timeView.image = [UIImage imageNamed:@"icon_date_blue"];
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 80, kWidth - 160, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor darkGrayColor];
        //_timeLabel.backgroundColor = [UIColor greenColor];
        
        UIImageView *nameView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 110, 20, 20)];
        nameView.image = [UIImage imageNamed:@"icon_sponsor_blue"];
        self.nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 110, kWidth - 160, 20)];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        _nameLabel.textColor = [UIColor darkGrayColor];
        //_nameLabel.backgroundColor = [UIColor orangeColor];
        
        UIImageView *typeView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 140, 20, 20)];
        typeView.image = [UIImage imageNamed:@"icon_catalog_blue"];
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 140, kWidth - 160, 20)];
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = [UIColor darkGrayColor];
        //_typeLabel.backgroundColor = [UIColor redColor];
        
        UIImageView *addressView = [[UIImageView alloc]initWithFrame:CGRectMake(130, 170, 20, 20)];
        addressView.image = [UIImage imageNamed:@"icon_spot_blue"];
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 170, kWidth - 160, 0)];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = [UIColor darkGrayColor];
        _addressLabel.numberOfLines = 0;
        //_addressLabel.backgroundColor = [UIColor blueColor];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 230, 150, 40)];
        //label.backgroundColor = [UIColor grayColor];
        label.text = @"活动介绍";
        label.font = [UIFont systemFontOfSize:25 weight:20];
        label.textColor = [UIColor darkGrayColor];
        
        self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 270, kWidth - 20, 0)];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textColor = [UIColor darkGrayColor];
        _contentLabel.numberOfLines = 0;
        //_contentLabel.backgroundColor = [UIColor cyanColor];
        
        [self addSubview:_titleLabel];
        [self addSubview:_timeLabel];
        [self addSubview:_addressLabel];
        [self addSubview:_typeLabel];
        [self addSubview:_nameLabel];
        [self addSubview:_contentLabel];
        [self addSubview:_pictureView];
        [self addSubview:timeView];
        [self addSubview:addressView];
        [self addSubview:typeView];
        [self addSubview:nameView];
        [self addSubview:label];
    }
    return self;
}

- (void)setActivity:(Activity *)activity{
    _titleLabel.text = activity.title;
    _timeLabel.text = [self getTime:activity];
    _nameLabel.text = activity.owner.name;
    _typeLabel.text = [NSString stringWithFormat:@"类型：%@",activity.category_name];
    _addressLabel.text = activity.address;
    _contentLabel.text = activity.content;
}

#pragma mark 返回一个拼接完整的时间
- (NSString *)getTime:(Activity *)activity{
    NSRange range = NSMakeRange(5, 11);
    NSString *string = [activity.begin_time substringWithRange:range];
    NSString *string1 = [activity.end_time substringWithRange:range];
    NSString *string2 = [NSString stringWithFormat:@"%@--%@",string,string1];
    return string2;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
