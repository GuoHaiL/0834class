//
//  RegistViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "RegistViewController.h"    //注册的Controller
#import "RegistView.h"              //注册的View
#import "DataBase.h"
#import "UserTableViewController.h"

@interface RegistViewController ()<UITextFieldDelegate>

@property (nonatomic, retain) DataBase *dataBase;

@end

@implementation RegistViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.navigationItem.title = @"注册";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(RegistClick:)];
        
        //创建数据库管理对象
        self.dataBase = [DataBase shareDataBase];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = @[@"用户名",@"密码",@"确认密码",@"邮箱",@"联系方式"];
    NSArray *array1 = @[@"请输入用户名",@"请输入密码",@"再次输入密码",@"请输入邮箱",@"请输入手机号"];
    for (int i = 0; i < 5; i++) {
        RegistView *registView = [[RegistView alloc]initWithFrame:CGRectMake(0, 30+60*i, 375, 100) andText:array[i] andPlaceHolder:array1[i]];
        registView.textField.tag = 1020+i;
        if (registView.textField.tag == 1021 || registView.textField.tag == 1022) {
            //密文输入
            registView.textField.secureTextEntry = YES;
        }
        registView.textField.delegate =self;
        
        [self.view addSubview:registView];
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 注册按钮点击事件
- (void)RegistClick:(UIBarButtonItem *)sender{
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:1020];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:1021];
    UITextField *tf3 = (UITextField *)[self.view viewWithTag:1022];
    
    if (![tf1.text isEqualToString:@""] && ![tf2.text isEqualToString:@""] && ![tf1.text hasPrefix:@" "] && ![tf2.text hasSuffix:@" "]) {
        
        for (User *str in [_dataBase selectAllUserName]) {
            if ([tf1.text isEqualToString:str.user]) {
                [self promptBox_1];
                return;
            }
        }
        
        if (![tf2.text isEqualToString:tf3.text]) {
            [self promptBox_2];
            return;
        }
        
        [_dataBase insertUserName:tf1.text userPwd:tf2.text];
        UserTableViewController *userVC = [[UserTableViewController alloc]init];
        [self.navigationController pushViewController:userVC animated:YES];
    }else{
        [self promptBox];
    }
}

#pragma mark 回收键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    UITextField *tf1 = (UITextField *)[self.view viewWithTag:1021];
    UITextField *tf2 = (UITextField *)[self.view viewWithTag:1022];
    UITextField *tf3 = (UITextField *)[self.view viewWithTag:1023];
    UITextField *tf4 = (UITextField *)[self.view viewWithTag:1024];
    
    if (textField.tag == 1020) {
        [tf1 becomeFirstResponder];
    }else if(textField.tag == 1021){
        [tf2 becomeFirstResponder];
    }else if(textField.tag == 1022){
        [tf3 becomeFirstResponder];
    }else if(textField.tag == 1023){
        [tf4 becomeFirstResponder];
    }
    
    [textField resignFirstResponder];
    return YES;
}
//点击空白区域，停止页面编辑
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

#pragma mark 注册弹框提示
- (void)promptBox{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名或密码不能为空" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:confirmAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark 注册用户名已存在
- (void)promptBox_1{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名已存在" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:confirmAction];
    [self presentViewController:alertC animated:YES completion:nil];
}

#pragma mark 密码不一致
- (void)promptBox_2{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认密码与密码不一致" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:confirmAction];
    [self presentViewController:alertC animated:YES completion:nil];
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
