//
//  MovieTableViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieTableViewController.h"
#import "MovieTableViewCell.h"
#import "MovieCollectionViewController.h"
#import "MovieDetailsTableViewController.h"
#import "MovieData.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"


static NSString *identifier = @"cellMovie";
@interface MovieTableViewController ()
@property(nonatomic,retain) MovieData *moviedata;

@end

@implementation MovieTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style{
    if ([super initWithStyle:style]) {
        self.navigationItem.title = @"电影";
        self.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"电影" image:[UIImage imageNamed:@"movie"] tag:1004];
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_collection@2x"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
        self.moviedata = [MovieData shareMovieData];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[MovieTableViewCell class] forCellReuseIdentifier:identifier];
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
    return _moviedata.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
  
//    cell.pictureView.image = [UIImage imageNamed:@"xiaomai_1.gif"];
    Movie *movie = [Movie new];
    movie = _moviedata.dataArray[indexPath.row];
    // Configure the cell...
    cell.titleLabel.text = movie.movieName;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });

    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url] placeholderImage:[UIImage imageNamed:@"xiaomai_1.gif"]];
    return cell;
}

- (void)click:(UIBarButtonItem *)sender{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    MovieCollectionViewController *movie = [[MovieCollectionViewController alloc]initWithCollectionViewLayout:layout];

    [self.navigationController pushViewController:movie animated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MovieDetailsTableViewController *movieDVC = [[MovieDetailsTableViewController alloc]initWithStyle:UITableViewStylePlain];
    Movie *movie = _moviedata.dataArray[indexPath.row];
    movieDVC.movieID = movie.movieId;
    movieDVC.titleString = movie.movieName;

    [self.navigationController pushViewController:movieDVC animated:YES];
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
