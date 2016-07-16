//
//  AppDelegate.h
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//
#import <sqlite3.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic) sqlite3 * sqliteDb;
@property (strong, nonatomic) UIWindow *window;


@end

