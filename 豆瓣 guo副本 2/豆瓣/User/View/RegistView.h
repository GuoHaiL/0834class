//
//  RegistView.h
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistView : UIView

@property (nonatomic, retain) UILabel *textlable;

@property (nonatomic, retain) UITextField *textField;


-(instancetype)initWithFrame:(CGRect)frame
                     andText:(NSString *)text
              andPlaceHolder:(NSString *)placeHolder;


@end
