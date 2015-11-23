//
//  TabBarViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "TabBarViewController.h"
#import "UserTableViewController.h"
#import "ActivityTableViewController.h"
#import "CinemaTableViewController.h"
#import "MovieTableViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        //初始化用户表视图控制器——userTabVC
        UserTableViewController *userTabVC = [[UserTableViewController alloc]initWithStyle:UITableViewStylePlain];
        
        //创建一个用户导航控制器——userNav，将userTabVC指定为根视图
        UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:userTabVC];
        
        ActivityTableViewController *activityTabVC = [[ActivityTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        UINavigationController *activityNav = [[UINavigationController alloc]initWithRootViewController:activityTabVC];
        
        CinemaTableViewController *cinemaTabVC = [[CinemaTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        UINavigationController *cinemaNav = [[UINavigationController alloc]initWithRootViewController:cinemaTabVC];
        
        MovieTableViewController *movieTabVC = [[MovieTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        UINavigationController *movieNav = [[UINavigationController alloc]initWithRootViewController:movieTabVC];
        
        self.viewControllers = @[activityNav, movieNav, cinemaNav, userNav];
    
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"bg_nav"] forBarMetrics:UIBarMetricsDefault];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
        // Do any additional setup after loading the view.
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
