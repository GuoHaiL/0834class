//
//  ActivityTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "ActivityTableViewController.h"
#import "ActivityTableViewCell.h"
#import "DetailsTableViewController.h"
#import "UIImageView+WebCache.h"
#define kURL_Activity @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/activitylist.php"
#define kWidth [UIScreen mainScreen].bounds.size.width
static NSString *identifier = @"cellReuse";
@interface ActivityTableViewController ()

@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation ActivityTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
        self.navigationItem.title = @"活动";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"活动" image:[UIImage imageNamed:@"activity"] tag:1001];
         self.dataArray = [NSMutableArray arrayWithCapacity:20];
        
        //1、创建url
        NSURL *url = [NSURL URLWithString:kURL_Activity];
        
        //2、创建请求对象
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        //3、建立会话，这是一个单例
        NSURLSession *session = [NSURLSession sharedSession];
        
        NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            //4、解析数据
            NSDictionary *outerDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            //NSLog(@"%@",outerDictionary);
            NSArray *array = outerDictionary[@"events"];
            for (NSDictionary *dic in array) {
                Activity *activity = [Activity new];
                Owner *owner = [Owner new];
                NSDictionary *dict = dic[@"owner"];
                [owner setValuesForKeysWithDictionary:dict];
                [activity setValuesForKeysWithDictionary:dic];
                activity.owner = owner;
                [_dataArray addObject:activity];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }];
        [task resume];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:identifier];
    //self.ActivityArray = [NSMutableArray array];
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
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    Activity *activity = _dataArray[indexPath.section];
    
    cell.activity = activity;
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:activity.image] placeholderImage:[UIImage imageNamed:@"xiaomai_1.gif"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsTableViewController *detailsVC = [[DetailsTableViewController alloc]initWithStyle:UITableViewStylePlain];
    detailsVC.activity = _dataArray[indexPath.section];
    [self.navigationController pushViewController:detailsVC animated:YES];
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
