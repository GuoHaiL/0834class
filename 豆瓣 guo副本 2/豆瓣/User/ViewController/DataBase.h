//
//  DataBase.h
//  UI_豆瓣豆瓣
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

#import "User.h"
#import "ActivityDataBase.h"

@interface DataBase : NSObject



+ (DataBase *)shareDataBase;

- (void)openDataBase;
- (void)deleteMoviedata:(NSString *)user andMovieName:(NSString *)movieName;
//注册添加用户
- (void)insertUserName:(NSString *)userName
               userPwd:(NSString *)userPwd;
- (NSArray *)selectAllUsersssss;
- (void)insertActivityData:(ActivityDataBase *)Data andUser:(NSString *)user;
- (void)insertMovieData:(NSString *)movieID andUser:(NSString *)user andmovieName:(NSString *)movieName;

- (NSArray *)selectActivityData:(NSString *)user;
- (NSDictionary *)selectMovieData:(NSString *)user;
//返回数据库中的所有用户名
- (NSArray *)selectAllUserName;

//- (void)deleteDataWithTitle:(NSString *)title;
//- (NSArray *)selectAllDatas:(NSString *)user;
//- (void)closeDataBase;




@end
