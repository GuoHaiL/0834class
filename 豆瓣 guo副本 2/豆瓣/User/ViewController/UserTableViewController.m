//
//  UserTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "UserTableViewController.h"    //用户的Controller
#import "loginViewController.h"        //登录的Controller
#import "MyActivityViewController.h"
#import "MyMovieViewController.h"
#import "UIImageView+WebCache.h"
@interface UserTableViewController ()

@property (nonatomic,retain)NSArray *dataArray;

@end
static NSString *identifier = @"cellReuse";
@implementation UserTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
        self.navigationItem.title = @"我的";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"user"] tag:1001];
        
        UIBarButtonItem *LoginBarBtn = [[UIBarButtonItem alloc]initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(BarBtnClick:)];
        LoginBarBtn.tintColor = [UIColor blackColor];
        self.navigationItem.rightBarButtonItem = LoginBarBtn;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.dataArray = @[@"我的活动",@"我的电影",@"清除缓存"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
     cell.textLabel.text = _dataArray[indexPath.row];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        MyActivityViewController *myActivity = [[MyActivityViewController alloc] init];
        [self.navigationController pushViewController:myActivity animated:YES];
    }else if (indexPath.row == 1){
        MyMovieViewController *myMovie = [[MyMovieViewController alloc] init];
        [self.navigationController pushViewController:myMovie animated:YES];
    }else if (indexPath.row == 2){
        NSUInteger size = [[SDImageCache sharedImageCache]getSize];
        NSString *string = [NSString stringWithFormat:@"清除缓存%luM",size/1024/1024];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"清除缓存" message:string preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertController animated:YES completion:^{
            
        }];
        [[SDImageCache sharedImageCache]clearMemory];
        [[SDImageCache sharedImageCache]cleanDisk];

        }
}
#pragma mark 登录跳转
- (void)BarBtnClick:(UIBarButtonItem *)sender{
    //登录页
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self presentViewController:nav animated:YES completion:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
