//
//  LoginView.h
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

//用户名、密码输入框
@property (nonatomic, retain) UITextField *userTfl;
@property (nonatomic, retain) UITextField *pwdTfl;

//登录、注册按钮
@property (nonatomic, retain) UIButton *loginBtn;
@property (nonatomic, retain) UIButton *registerBtn;

@end
