//
//  CinemaTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "CinemaTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@implementation CinemaTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_eventlistcell"]];
        backgroundImageView.frame = CGRectMake(0, 0, kWidth, 160);
        self.backgroundView = backgroundImageView;
        
        self.cinemaNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, kWidth - 20, 50)];
        //_cinemaNameLabel.backgroundColor = [UIColor redColor];
        _cinemaNameLabel.font = [UIFont systemFontOfSize:20 weight:20];
        [self addSubview:_cinemaNameLabel];
        
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, kWidth - 20, 50)];
        _addressLabel.numberOfLines = 0;
        _addressLabel.font = [UIFont systemFontOfSize:17];
        //_addressLabel.backgroundColor = [UIColor greenColor];
        _addressLabel.textColor = [UIColor grayColor];
        [self addSubview:_addressLabel];
        
        self.telephoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 160 - 30, kWidth - 20, 30)];
        _telephoneLabel.textColor = [UIColor grayColor];
        // _telephoneLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:_telephoneLabel];
        
        
    }
    return self;
}

- (void)setCinema:(Cinema *)cinema{
    _cinemaNameLabel.text = cinema.cinemaName;
    _addressLabel.text = cinema.address;
    _telephoneLabel.text = cinema.telephone;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
