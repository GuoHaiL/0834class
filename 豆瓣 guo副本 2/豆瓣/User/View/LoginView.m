//
//  LoginView.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        UILabel *userLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 50, 100, 50)];
        userLabel.text = @"用户名:";
        userLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:userLabel];
        
        self.userTfl = [[UITextField alloc]initWithFrame:CGRectMake(140, 60, 200, 40)];
        _userTfl.placeholder = @"请输入用户名";
        _userTfl.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_userTfl];
        
        UILabel *pwdLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 110, 100, 50)];
        pwdLabel.text = @"密码:";
        pwdLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:pwdLabel];
        
        self.pwdTfl = [[UITextField alloc]initWithFrame:CGRectMake(140, 120, 200, 40)];
        _pwdTfl.placeholder = @"请输入密码";
        _pwdTfl.borderStyle = UITextBorderStyleRoundedRect;
        [self addSubview:_pwdTfl];
        
        self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _loginBtn.frame = CGRectMake(20, 180, 150, 50);
        _loginBtn.backgroundColor = [UIColor greenColor];
        _loginBtn.alpha = 0.4;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 5;
        
        [self addSubview:_loginBtn];
        
        self.registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _registerBtn.frame = CGRectMake(190, 180, 150, 50);
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.contentsScale = 10;
        _registerBtn.backgroundColor = [UIColor orangeColor];
        _registerBtn.alpha = 0.7;
        _registerBtn.layer.masksToBounds = YES;
        _registerBtn.layer.cornerRadius = 5;
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [self addSubview:_registerBtn];

        
    }
    return self;
}

@end
