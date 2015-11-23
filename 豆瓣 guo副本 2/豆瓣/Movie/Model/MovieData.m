//
//  MovieData.m
//  UI_豆瓣
//
//  Created by 郭海林 on 15/10/22.
//  Copyright © 2015年 郭海林. All rights reserved.
//

#import "MovieData.h"
#import "Movie.h"
#define BASE_URL @"http://project.lanou3g.com/teacher/yihuiyun/lanouproject/movielist.php"
static MovieData *moviedata = nil;
@implementation MovieData
+(MovieData *)shareMovieData{
    if (moviedata == nil) {
        moviedata = [MovieData new];
        [moviedata shareMovie];
    }
    return moviedata;
    
}
-(void)shareMovie{
    NSURL *url = [NSURL URLWithString:BASE_URL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"post"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSArray *array = dic[@"result"];
        __weak typeof (self)temp = self;
        temp.dataArray = [NSMutableArray arrayWithCapacity:5];
        for (NSDictionary *dic in array) {
            Movie *movie = [Movie new];
            [movie setValuesForKeysWithDictionary:dic];
            [_dataArray addObject:movie];
            
            
        }
        
 
        
        
    }];

    [task resume];
}

@end
