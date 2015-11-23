//
//  UserDataBase.h
//  豆瓣
//
//  Created by 郭海林 on 15/10/28.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBase.h"
@interface UserDataBase : NSObject
@property(nonatomic, retain)DataBase *dataBase;
+(UserDataBase *)shareDataBase;
-(void)openDB;
-(void)closeDB;
-(NSArray *)selectAllUserName;
@end
