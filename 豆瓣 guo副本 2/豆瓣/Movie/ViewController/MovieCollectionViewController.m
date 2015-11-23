//
//  MovieCollectionViewController.m
//  豆瓣
//
//  Created by lanou3g on 15/10/22.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "MovieCollectionViewController.h"
#import "MovieDetailsTableViewController.h"
#import "MovieCollectionViewCell.h"
#import "MovieData.h"
#import "Movie.h"
#import "UIImageView+WebCache.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
@interface MovieCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property(nonatomic, retain)MovieData *moviedata;

@end

@implementation MovieCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
- (instancetype)initWithCollectionViewLayout:(UICollectionViewFlowLayout *)layout{
    if ([super initWithCollectionViewLayout:layout]) {
        //行间距
        layout.minimumLineSpacing = 30;
        layout.itemSize = CGSizeMake(kWidth/3 - 25, 150);
        layout.headerReferenceSize = CGSizeMake(10, 30);
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        
        self.navigationItem.title = @"电影";
        //隐藏返回按钮
        self.navigationItem.hidesBackButton = YES;
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"btn_nav_list@2x"] imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(click:)];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.moviedata = [MovieData shareMovieData];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MovieCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return _moviedata.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
//    cell.pictureView.image = [UIImage imageNamed:@"xiaomai_1.gif"];
    Movie *movie = _moviedata.dataArray[indexPath.row];
    // Configure the cell
    cell.movie = movie;
    [cell.pictureView sd_setImageWithURL:[NSURL URLWithString:movie.pic_url] placeholderImage:[UIImage imageNamed:@"xiaomai_1.gif"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieDetailsTableViewController *movieDVC = [[MovieDetailsTableViewController alloc]initWithStyle:UITableViewStylePlain];
    
    Movie *movie = _moviedata.dataArray[indexPath.row];
    movieDVC.movieID = movie.movieId;
    movieDVC.titleString = movie.movieName;
    
    [self.navigationController pushViewController:movieDVC animated:YES];
}

- (void)click:(UIBarButtonItem *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
