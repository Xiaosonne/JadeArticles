//
//  PcontentModel.h
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/16.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface PcontentModel : NSObject
@property(nonatomic) NSInteger ContentType;
@property(nonatomic) NSInteger Order;
@property(nonatomic,strong) NSString* Content;
@property(nonatomic) NSInteger rowHeight ;
+(instancetype) InstanceFromStmt:(sqlite3_stmt *) stmt;

@end
