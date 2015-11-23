//
//  CinemaTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "CinemaTableViewController.h"
#import "CinemaTableViewCell.h"
#define kUrl_Cinema @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/cinemalist.php"

//接口

static NSString *identifier = @"CinemaCell";

@interface CinemaTableViewController ()
// 创建数组
@property (nonatomic, retain) NSMutableArray * array;


@end

@implementation CinemaTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
        self.navigationItem.title = @"影院";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"影院" image:[UIImage imageNamed:@"cinema"] tag:1003];
    
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[CinemaTableViewCell class] forCellReuseIdentifier:identifier];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // 解析
    [self dataAnalysis];
    
}
//懒加载
- (NSMutableArray *)array{
    if (_array == nil) {
        _array = [NSMutableArray arrayWithCapacity:5];
    }
    return _array;
}

// 解析网络数据
- (void)dataAnalysis{

    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kUrl_Cinema]];
    NSURLSession * session = [NSURLSession sharedSession];
    __weak typeof(self) temp = self;
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary * dicy = dic[@"result"];
        NSArray * array = dicy[@"data"];
        
        for (NSDictionary * dice in array) {
            Cinema * cinema = [Cinema new];
            [cinema setValuesForKeysWithDictionary:dice];
            [temp.array addObject:cinema];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
             });
        
      
    }];
    [dataTask resume];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return _array.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    Cinema * cinema = _array[indexPath.section];
    cell.cinema = cinema;
    // Configure the cell...
    
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Cinema * cinema = _array[indexPath.section];
    
    return 160;
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
