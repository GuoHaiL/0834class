//
//  MovieDetailsTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/23.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieDetailsTableViewController.h"
#import "MovieDetailsTableViewCell.h"
#import "MovieDetails.h"
#import "DataBase.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define BASE_URL1 @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/searchmovie.php?movieId="
static NSString *identifier = @"MovieDetailsCell";

@interface MovieDetailsTableViewController ()
@property (nonatomic, retain) MovieDetails *movie;
@property (nonatomic, retain)DataBase *dataBase;
@end

@implementation MovieDetailsTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_back"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backClick:)];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_share"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(collect:)];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _titleString;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[MovieDetailsTableViewCell class] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSMutableString *string = [NSMutableString stringWithString:BASE_URL1];
    [string appendString:_movieID];
    NSURL *url = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSDictionary *dic1 = dic[@"result"];
        NSLog(@"%@",dic);
        MovieDetails *movie = [MovieDetails new];
        [movie setValuesForKeysWithDictionary:dic1];
        self.movie = movie;
        
}];
    [task resume];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//    [self.tableView reloadData];
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
//    if (_movieDetails == nil) {
//        [self.tableView reloadData];
//    }
    MovieDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    

//    cell.posterView.image = [UIImage imageNamed:@"xiaomai_1.gif"];
    // Configure the cell...
//
    cell.movieDetails = _movie;
       CGRect text = [cell.plot_simpleLabel.text boundingRectWithSize:CGSizeMake(kWidth - 20, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
       cell.plot_simpleLabel.frame = CGRectMake(10, 330, kWidth-15,text.size.height);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [cell.posterView sd_setImageWithURL:[NSURL URLWithString:_movie.poster] placeholderImage:[UIImage imageNamed:@"xiaomai_1.gif"]];
        
    });
    __weak typeof (self)temp = self;
    dispatch_group_notify(dispatch_group_create(), dispatch_get_main_queue(), ^{
        [temp.tableView reloadData];
    });
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330 + [self getTextHeight:_movie.plot_simple];
}

- (void)collect:(UIBarButtonItem *)sender{
    
    self.dataBase = [DataBase shareDataBase];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *name = [user objectForKey:@"user"];
    NSDictionary *dic = [_dataBase selectMovieData:name];
    NSArray *array = [dic objectForKey:@"movieID"];
    NSLog(@"array = %lu",array.count);
    for (NSString *ID in array) {
        NSLog(@"%@",ID);
        if ([ID isEqualToString:_movieID]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"警告" message:@"收藏失败" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:action];
            [self presentViewController:alert animated:YES completion:nil];
            return;
        }
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

    [_dataBase insertMovieData:_movieID andUser:name andmovieName:_titleString];
   
    
    NSLog(@"收藏成功");
}

- (void)backClick:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)getTextHeight:(NSString *)string{
    CGRect text = [string boundingRectWithSize:CGSizeMake(355, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} context:nil];
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
