//
//  DataBase.m
//  UI_豆瓣豆瓣
//
//  Created by lanou3g on 15/10/28.
//  Copyright © 2015年 yrh.com. All rights reserved.
//

#import "DataBase.h"
#import "ActivityDataBase.h"
#import "User.h"
@implementation DataBase
static DataBase * dataBase = nil;
static sqlite3 * db = nil;

+ (DataBase *)shareDataBase{
    @synchronized(self) {
        if (dataBase == nil) {
            dataBase = [[DataBase alloc] init];
            [dataBase openDataBase];
        }
        return dataBase;
    }
}

- (void)openDataBase{
    if (db != nil) {
        return;
    }
    NSString * documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * path = [documentPath stringByAppendingPathComponent:@"DataBase.sqlite"];
    NSLog(@"%@",path);
    int result = sqlite3_open([path UTF8String], &db);
    if (result == SQLITE_OK) {
        NSString * sql1 = @"CREATE TABLE UserDataBase (user TEXT, pass TEXT)";
         NSString * sql2 = @"CREATE TABLE ActivityDataBase (user TEXT, activityData BLOB)";
         NSString * sql3 = @"CREATE TABLE movieData (user TEXT, movieID TEXT, movieName TEXT)";
        sqlite3_exec(db, [sql1 UTF8String], NULL, NULL, NULL);
        sqlite3_exec(db, [sql2 UTF8String], NULL, NULL, NULL);
        sqlite3_exec(db, [sql3 UTF8String], NULL, NULL, NULL);
        NSLog(@"open OK");
    }else{
        NSLog(@"open NO %d",result);
    }
    
}

- (void)insertUserName:(NSString *)userName
               userPwd:(NSString *)userPwd{
    //1、打开数据库
    [self openDataBase];
    
    //2、创建跟随指针
    sqlite3_stmt *stmt = nil;
    
    //3、准备添加sql语句
    NSString *sql = @"INSERT INTO UserDataBase (user,pass) VALUES (?,?)";
    
    //4、验证是否正确
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    
    if (result == SQLITE_OK) {
        NSLog(@"添加成功");
        
        //5、sql语句正确，开始绑定数据
        sqlite3_bind_text(stmt, 1, [userName UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [userPwd UTF8String], -1, NULL);
        
        //6、单步执行
        sqlite3_step(stmt);
        
    }else{
        NSLog(@"添加失败");
    }
    //释放
    sqlite3_finalize(stmt);
}


- (void)insertActivityData:(ActivityDataBase *)Data andUser:(NSString *)user{
    [self openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"INSERT INTO ActivityDataBase (user,activityData) VALUES(?,?)";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
        // 归档activityData
        NSMutableData * data = [NSMutableData data];
        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:Data forKey:@"activity"];
        [archiver finishEncoding];
        
        sqlite3_bind_blob(stmt, 2, [data bytes], (int)[data length], NULL);
        
        sqlite3_step(stmt);
        
        NSLog(@"insert OK");
    }else {
        NSLog(@"insert NO %d",result);
    }
    
    sqlite3_finalize(stmt);
    
    
    
}
- (void)insertMovieData:(NSString *)movieID andUser:(NSString *)user andmovieName:(NSString *)movieName {
    [self openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"INSERT INTO movieData (user,movieId,movieName) VALUES(?,?,?)";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 2, [movieID UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3,[movieName UTF8String] , -1, NULL);
        sqlite3_step(stmt);
        
        NSLog(@"insert OK");
    }else {
        NSLog(@"insert NO %d",result);
    }
    
    sqlite3_finalize(stmt);
}

- (NSArray *)selectActivityData:(NSString *)user{
    [self openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"select * from ActivityDataBase where user = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:50];
        sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            
            //取data：内容、大小
            //内容
            sqlite3_column_blob(stmt, 1);
            //大小
            sqlite3_column_bytes(stmt, 1);
            
            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 1) length:sqlite3_column_bytes(stmt, 1)];
            // 反归档
            
            NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
            ActivityDataBase * activity = [unarchiver decodeObjectForKey:@"activity"];
            NSLog(@"act = %@",activity);
            [unarchiver finishDecoding];
            
            [array addObject:activity];
       
        }
        sqlite3_finalize(stmt);
        NSLog(@"select OK");
        return array;
    }else{
        NSLog(@"select NO %d", result);
    }
    sqlite3_finalize(stmt);
    return nil;

}
- (NSDictionary *)selectMovieData:(NSString *)user{
    [self openDataBase];
    sqlite3_stmt * stmt = nil;
    NSString * sql = @"select * from movieData where user = ?";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
    if (result == SQLITE_OK) {
        NSMutableArray * array = [NSMutableArray arrayWithCapacity:50];
        NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:5];
               sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString * movieID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 1)];
            NSString * movieName = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt,2)];
            [array addObject:movieID];
            [array1 addObject:movieName];
            NSLog(@"array1 = %lu",array.count);
            
        }
        [dic setObject:array forKey:@"movieID"];
        [dic setObject:array1 forKey:@"movieName"];
        sqlite3_finalize(stmt);
        NSLog(@"select OK");
        return dic;
           }else{
        NSLog(@"select NO %d", result);
    }
    sqlite3_finalize(stmt);
    return nil;

}

- (NSArray *)selectAllUserName{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    NSString *sql = @"SELECT*FROM UserDataBase";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSString *user = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
            NSString *pass = [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
            User *person = [User new];
            person.user = user;
            person.pass = pass;
            [array addObject:person];
        }
        sqlite3_finalize(stmt);
        return array;
    }else{
        NSLog(@"查找失败");
    }
    sqlite3_finalize(stmt);
    return nil;
}
- (void)deleteMoviedata:(NSString *)user andMovieName:(NSString *)movieName{
    [self openDataBase];
    sqlite3_stmt *stmt = nil;
    NSString *sql = @"DELETE FROM movieData WHERE user = ? AND movieName = ? ";
    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
    if (result == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
        sqlite3_bind_text(stmt, 3, [movieName UTF8String], -1, NULL);
        sqlite3_step(stmt);
        sqlite3_finalize(stmt);
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败%d",result);
    }
    
}
//- (void)insertData:(DataModel *)Data{
//    [self openDataBase];
//    sqlite3_stmt * stmt = nil;
//    NSString * sql = @"INSERT INTO UserDataBase (user,pass,movieId,activityData) VALUES(?,?,?,?)";
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        sqlite3_bind_text(stmt, 1, [Data.user UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 2, [Data.pass UTF8String], -1, NULL);
//        sqlite3_bind_text(stmt, 3, [Data.movieId UTF8String], -1, NULL);
//        // 归档activityData
//        NSMutableData * data = [NSMutableData data];
//        NSKeyedArchiver * archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
//        [archiver encodeObject:Data.activityData forKey:@"activity"];
//        [archiver finishEncoding];
//        sqlite3_bind_blob(stmt, 4, [data bytes], (int)[data length], NULL);
//        
//        sqlite3_step(stmt);
//        
//        NSLog(@"insert OK");
//    }else {
//        NSLog(@"insert NO %d",result);
//    }
//    
//    sqlite3_finalize(stmt);
//    
//}
//- (void)deleteDataWithTitle:(NSString *)title;
//- (NSArray *)selectAllDatas:(NSString *)user{
//    [self openDataBase];
//    sqlite3_stmt * stmt = nil;
//    NSString * sql = @"select * from UserDataBase where user = ?";
//    int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);
//    if (result == SQLITE_OK) {
//        NSMutableArray * array = [NSMutableArray arrayWithCapacity:50];
//        sqlite3_bind_text(stmt, 1, [user UTF8String], -1, NULL);
//        DataModel * model = [DataModel new];
//        while (sqlite3_step(stmt) == SQLITE_ROW) {
//            NSString * user = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 0)];
//            NSString * pass = [NSString stringWithUTF8String:(const char *) sqlite3_column_text(stmt, 1)];
//            NSString * movieID = [NSString stringWithUTF8String:(const char *)sqlite3_column_text(stmt, 2)];
//            
//            //取data：内容、大小
//            //内容
//            sqlite3_column_blob(stmt, 3);
//            //大小
//            sqlite3_column_bytes(stmt, 3);
//            
//            NSData * data = [NSData dataWithBytes:sqlite3_column_blob(stmt, 3) length:sqlite3_column_bytes(stmt, 3)];
//            // 反归档
//            
//            NSKeyedUnarchiver * unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
//            ActivityDataBase * activity = [unarchiver decodeObjectForKey:@"activity"];
//            [unarchiver finishDecoding];
//            
//            model.user = user;
//            model.pass = pass;
//            model.movieId = movieID;
//            model.activityData = activity;
//            
//            [array addObject:model];
//            
//            sqlite3_finalize(stmt);
//            NSLog(@"select OK");
//            return array;
//        }
//    }else{
//        NSLog(@"select NO %d", result);
//    }
//    sqlite3_finalize(stmt);
//    return nil;
//}

//- (void)closeDataBase;


@end
