//
//  ActivityTableViewCell.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "ActivityTableViewCell.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

@implementation ActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *backgroundImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_eventlistcell"]];
        backgroundImageView.frame = CGRectMake(0, 0, kWidth, 200);
        self.backgroundView = backgroundImageView;
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, kWidth - 20, 30)];
        _titleLabel.textColor = [UIColor darkGrayColor];
        //_titleLabel.backgroundColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        //内层视图
        UIView *FrameView = [[UIView alloc]initWithFrame:CGRectMake(5, 40, kWidth - 10, 150)];
        FrameView.backgroundColor = [UIColor whiteColor];
        self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 5, kWidth - 160, 20)];
        _timeLabel.font = [UIFont systemFontOfSize:15];
        _timeLabel.textColor = [UIColor darkGrayColor];
        //_timeLabel.backgroundColor = [UIColor greenColor];
        UIImageView *timeView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        timeView.image = [UIImage imageNamed:@"icon_date"];
        
        self.addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 30, kWidth - 170, 20)];
        _addressLabel.font = [UIFont systemFontOfSize:15];
        _addressLabel.textColor = [UIColor darkGrayColor];
        //_addressLabel.backgroundColor = [UIColor redColor];
        UIImageView *addressView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 30, 20, 20)];
        addressView.image = [UIImage imageNamed:@"icon_spot"];
        
        self.typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(25, 55, 220, 20)];
        _typeLabel.font = [UIFont systemFontOfSize:15];
        _typeLabel.textColor = [UIColor darkGrayColor];
        //_typeLabel.backgroundColor = [UIColor blueColor];
        UIImageView *typeView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 55, 20, 20)];
        typeView.image = [UIImage imageNamed:@"icon_catalog"];

        
        self.interestLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 110, 100, 30)];
        _interestLabel.font = [UIFont systemFontOfSize:15];
        _interestLabel.textColor = [UIColor darkGrayColor];
        //_interestLabel.backgroundColor = [UIColor cyanColor];
        
        self.joinLabel = [[UILabel alloc]initWithFrame:CGRectMake(130, 110, 100, 30)];
        _joinLabel.font = [UIFont systemFontOfSize:15];
        _joinLabel.textColor = [UIColor darkGrayColor];
        //_joinLabel.backgroundColor = [UIColor orangeColor];
        
        self.pictureView = [[UIImageView alloc]initWithFrame:CGRectMake(kWidth - 130, 5, 110, 140)];
        //imageView.backgroundColor = [UIColor grayColor];

        [FrameView addSubview:_timeLabel];
        [FrameView addSubview:_addressLabel];
        [FrameView addSubview:_typeLabel];
        [FrameView addSubview:_interestLabel];
        [FrameView addSubview:_joinLabel];
        [FrameView addSubview:_pictureView];
        [FrameView addSubview:timeView];
        [FrameView addSubview:addressView];
        [FrameView addSubview:typeView];
        
        [self addSubview:FrameView];
        
    }
    return self;
}

- (void)setActivity:(Activity *)activity{
    _titleLabel.text = activity.title;
    _timeLabel.text = [self getTime:activity];
    _addressLabel.text = activity.address;
    _typeLabel.text = [NSString stringWithFormat:@"类型：%@",activity.category_name];
    _interestLabel.attributedText = [self changeFontColor:activity][0];
    _joinLabel.attributedText = [self changeFontColor:activity][1];
    
}

#pragma mark 返回包含interestLabel、joinLabel两个文本信息的数组
- (NSArray *)changeFontColor:(Activity *)activity{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"感兴趣：%ld",activity.wisher_count]];
    
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"参加：%ld",activity.participant_count]];

    [str addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18],NSFontAttributeName, nil]range:NSMakeRange(4, str.length - 4)];
    
    [str1 addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor redColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil] range:NSMakeRange(3, str1.length - 3)];
    
    //NSLog(@"%@, %@",str, str1);
    return @[str, str1];
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
