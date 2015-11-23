//
//  MovieData.h
//  UI_豆瓣
//
//  Created by 郭海林 on 15/10/22.
//  Copyright © 2015年 郭海林. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieData : NSObject
@property(nonatomic, retain)NSMutableArray *dataArray;

+(MovieData *)shareMovieData;
@end
