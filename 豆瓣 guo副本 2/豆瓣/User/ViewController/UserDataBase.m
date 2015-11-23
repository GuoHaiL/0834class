//
//  UserDataBase.m
//  豆瓣
//
//  Created by 郭海林 on 15/10/28.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import "UserDataBase.h"
#import <sqlite3.h>
#import "User.h"
static UserDataBase *dataBase = nil;
@implementation UserDataBase
+(UserDataBase *)shareDataBase{
    @synchronized(self) {
        if (dataBase == nil) {
            dataBase = [UserDataBase new];
            [dataBase openDB];
        }
    }
    return dataBase;
}
static sqlite3 *db = nil;
//-(void)openDB{
//    if (db != nil) {
//        return;
//    }
//    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
//    NSString *path = [documentPath stringByAppendingString:@"/User.sqlite"];
//  
//    int result = sqlite3_open([path UTF8String], &db);
//    if (result == SQLITE_OK) {
//        NSString *sql = @"CREATE TABLE UserDataBase (user TEXT, pass TEXT, movieId TEXT, activityData BLOB)";
//        sqlite3_exec(db, [sql UTF8String], NULL, NULL, NULL);
//        
//        NSLog(@"创建成功");
//    }else{
//        NSLog(@"创建失败:%d",result);
//    }
//    
//    
//}
-(void)closeDB{
    int result = sqlite3_close(db);
    if (result == SQLITE_OK) {
        NSLog(@"关闭成功");
        db = nil;
    }else{
        NSLog(@"关闭失败%d",result);
    }
    
}
-(NSArray *)selectAllUserName{
    [self openDB];
    sqlite3_stmt *stmt = nil;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    NSString *sql = @"SELECT*FROM UserDataBase";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
        NSString *name = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
            NSString *password = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            User *user = [[User alloc]init];
            user.user = name;
            user.pass = password;
        [array addObject:user];
    }
    sqlite3_finalize(stmt);
    return array;
}else{
    NSLog(@"查找失败");
}
    
    sqlite3_finalize(stmt);
    return nil;
}
@end
