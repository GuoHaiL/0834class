//
//  LoginViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "LoginViewController.h"       //登录的Controller
#import "LoginView.h"                 //登录的View
#import "RegistViewController.h"      //注册的Controller
//#import "UserDataBase.h"
#import "DataBase.h"
#import "User.h"
@interface LoginViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) LoginView *loginView;
//@property(nonatomic, retain)UserDataBase *dataBase;
@property(nonatomic, retain)DataBase * dataBase;
@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title = @"用户登录";
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
        self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
            }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //初始化登录View
    LoginView *loginView = [[LoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.loginView = loginView;
    _loginView.userTfl.tag = 1001;
    _loginView.userTfl.delegate = self;
    _loginView.pwdTfl.tag = 1002;
    _loginView.pwdTfl.delegate = self;
    
    [self.view addSubview:loginView];
    self.dataBase = [DataBase shareDataBase ];
      
    //给注册按钮添加事件
    [loginView.registerBtn addTarget:self action:@selector(registerClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //给登录按钮添加事件
    [loginView.loginBtn addTarget:self action:@selector(loginClick:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:1002];

    if (textField.tag == 1001) {
        [tf1 becomeFirstResponder];
    }
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 登录按钮的点击跳转
- (void)loginClick:(UIButton *)sender{
    UITextField *fie1 = (UITextField *)[self.view viewWithTag:1001];
    UITextField *fie2 = (UITextField *)[self.view viewWithTag:1002];
    if ([fie1.text isEqualToString:@""] || [fie2.text isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"登录失败" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        return;
    }
    NSArray *array = [_dataBase selectAllUserName];
    for (User *user in array) {
        NSLog(@"user = %@",user.user);
        if ([user.user isEqualToString: fie1.text] && [fie2.text isEqualToString: user.pass]) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                
            }];
            NSString *name = fie1.text;
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:name forKey:@"user"];
            NSLog(@"name = %@",name);
            return;

        }
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"登录失败" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:^{
        
    }];
    
    
    
    
    
    

}

#pragma mark 注册按钮的点击跳转
- (void)registerClick:(UIButton *)sender{
    RegistViewController *regisVC = [[RegistViewController alloc]init];
    
    [self.navigationController pushViewController:regisVC animated:YES];
}

#pragma mark 返回按钮
- (void)back:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
