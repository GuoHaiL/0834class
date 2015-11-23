//
//  DetailsTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "DetailsTableViewController.h"
#import "DetailsTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DataBase.h"

#define kWidth [UIScreen mainScreen].bounds.size.width

static NSString *idnetifier = @"DetailsCell";
@interface DetailsTableViewController ()

@property (nonatomic, retain) DataBase *dataBase;

@end

@implementation DetailsTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
         self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(collect:)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = _activity.title;
    [self.tableView registerClass:[DetailsTableViewCell class] forCellReuseIdentifier:idnetifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idnetifier forIndexPath:indexPath];

    cell.activity = _activity;
    cell.addressLabel.frame = CGRectMake(150, 170, kWidth - 160, [self getAddressHeight:_activity.address]);
    cell.contentLabel.frame = CGRectMake(10, 270, kWidth - 20, [self getContentHeight:_activity.content]);
    cell.titleLabel.frame = CGRectMake(10, 20, kWidth - 20, [self getTitleHeight:_activity.title]);
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:_activity.image] placeholderImage:[UIImage imageNamed:@"xiaomai_1.gif"]];
    
    // Configure the cell...
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 270 + [self getContentHeight:_activity.content];
}

- (void)collect:(UIBarButtonItem *)sender{
    self.dataBase = [DataBase shareDataBase];
    ActivityDataBase * da = [ActivityDataBase new];
    
    da.title = _activity.title;
    da.image = _activity.image;
    da.begin_time = _activity.begin_time;
    da.eng_time = _activity.end_time;
    da.name = _activity.owner.name;
    da.category_name = _activity.category_name;
    da.address = _activity.address;
    da.countent = _activity.content;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *name = [user objectForKey:@"user"];
    NSLog(@"%@",name);
    NSArray *array = [_dataBase selectActivityData:name];
    NSLog(@"%@",array);
    for (ActivityDataBase *act in array) {
        if ([act.title isEqualToString:da.title]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"已经收藏" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:^{
                
            }];
            return;

        }
    }
    [_dataBase insertActivityData:da andUser:name];
}

- (void)backClick:(UIBarButtonItem *)sender{
    
   [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)getContentHeight:(NSString *)string{
    CGRect text = [string boundingRectWithSize:CGSizeMake(kWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return text.size.height;
}

- (CGFloat)getAddressHeight:(NSString *)string{
    CGRect text = [string boundingRectWithSize:CGSizeMake(kWidth - 160, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    return text.size.height;
}

- (CGFloat)getTitleHeight:(NSString *)string{
    CGRect text = [string boundingRectWithSize:CGSizeMake(kWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]} context:nil];
    return text.size.height;
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
