//
//  PcontentModel.m
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/16.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import "PcontentModel.h"
//[Order],[Content],[ContentType]
@implementation PcontentModel
+(instancetype) InstanceFromStmt:(sqlite3_stmt *) stmt {
    PcontentModel* model=[[PcontentModel alloc] init];
    model.Order= sqlite3_column_int(stmt, 0);
    
    model.ContentType=sqlite3_column_int(stmt, 2);
    NSString* ct1=[NSString stringWithUTF8String:sqlite3_column_text(stmt, 1)];
    ct1= [ct1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet ]];
    if (model.ContentType==1)
    {
        ct1=[@"  " stringByAppendingString:ct1];
    }
    model.Content=ct1;
    return model;
}
@end
