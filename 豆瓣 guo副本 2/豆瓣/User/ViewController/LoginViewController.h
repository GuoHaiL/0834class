//
//  LoginViewController.h
//  豆瓣
//
//  Created by lanou3g on 15/10/20.
//  Copyright © 2015年 www.aiqiyi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NameDelegate <NSObject>

-(void)nameDelegate:(NSString *)name;

@end



@interface LoginViewController : UIViewController
@property(nonatomic, retain)NSString *name;
@property(nonatomic, assign)id<NameDelegate>delegate;
@end
