//
//  RegistView.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "RegistView.h"

@implementation RegistView
-(instancetype)initWithFrame:(CGRect)frame andText:(NSString *)text andPlaceHolder:(NSString *)placeHolder{
    self = [super initWithFrame:frame];
    if (self) {
        self.textlable = [[UILabel alloc]initWithFrame:CGRectMake(0, (frame.size.height-40)/2.0, frame.size.width/3.0, 40)];
        _textlable.text = text;
        _textlable.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_textlable];
        
        
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(frame.size.width/3.0, (frame.size.height - 40)/2.0, frame.size.width/2.0, 40)];
        _textField.placeholder = placeHolder;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        //_textField.keyboardType = UIKeyboardTypeDefault;
        //_textField.enabled = YES;
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_textField];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
