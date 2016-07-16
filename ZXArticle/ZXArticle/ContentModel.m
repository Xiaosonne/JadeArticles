//
//  ContentModel.m
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import <sqlite3.h>
#import "ContentModel.h"
#import "NSString+Extension.h"
#import "PcontentModel.h"
@implementation ContentModel
+(instancetype)InstanceFromStmt:(sqlite3_stmt*)stmt
{
    ContentModel* cm=[[ContentModel alloc] init];
    cm.Url= [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 0)];
    cm.Head= [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 1)];
    cm.Description= [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 2)];
    cm.UrlPic= [NSString stringWithUTF8String:(const char*)sqlite3_column_text(stmt, 3)];
    cm.loadImgCompleted=NO;
    cm.loadingImg=NO;
    [cm measureSize ];
    [cm loadImage];
    return cm;
}
+(NSArray*) Select:(NSString*) sqlSelect;
{
    //NSArray* arrPath=NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    //NSString* dbPath=[[arrPath objectAtIndex:0] stringByAppendingPathComponent:db_name];
    NSMutableArray * arr=[NSMutableArray array];
    sqlite3 * db;
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"db.sqlite" ofType:nil];
    NSLog(@"dbpath %@ ",dbPath);
    int state=0;
    state=sqlite3_open([dbPath UTF8String], &db);
    if (state!=SQLITE_OK) {
        sqlite3_close(db);
        printf("open db error %d ",state);
    }
    NSLog(@"[EXEC SQL] %@",sqlSelect);
    sqlite3_stmt* stmt;
    state=sqlite3_prepare_v2(db, [sqlSelect UTF8String], -1, &stmt, nil);
    state=sqlite3_step(stmt);
    while (state==SQLITE_ROW)
    {
        [arr addObject:[ContentModel InstanceFromStmt:stmt]];
        state=sqlite3_step(stmt);
    }
    sqlite3_close(db);
    return arr;
}
-(void) measureSize{
    CGRect rect= [[UIScreen mainScreen] bounds];
    NSInteger imgMargin=10;
    NSInteger imgLength=50;
    NSInteger left=10;
    NSInteger rightWidth=rect.size.width-20;
    UIFont* font=[UIFont systemFontOfSize:20];
    UIFont* font2=[UIFont systemFontOfSize:15];
    CGSize headSize=[self.Head measureTextWithFont:font inSize:CGSizeMake(rightWidth, MAXFLOAT) ];
    CGSize desciptionSize=[self.Description measureTextWithFont:font2 inSize:CGSizeMake( rightWidth, MAXFLOAT)];
    self.headRect=CGRectMake(left, 10, headSize.width, headSize.height);
    self.imgRect=CGRectMake(imgMargin,self.headRect.origin.y+self.headRect.size.height+20 , rightWidth, rightWidth);
   
    self.despRect=CGRectMake(left , self.imgRect.size.height+self.imgRect.origin.y+10, desciptionSize.width, desciptionSize.height+10);
    self.heightForRow=self.imgRect.size.height+10+ self.headRect.size.height+10+self.despRect.size.height+10+10;
}
-(void) loadImage
{
    if (self.loadImgCompleted==YES) {
        return;
    }
    if (self.loadingImg==YES) {
        return;
    }
    self.loadingImg=YES;
    NSLog(@"[DOWNLOAD IMAGE ] %@ ",self.Url);
    NSURL* url=[[NSURL alloc] initWithString:self.UrlPic];
    NSURLRequest * request=[[NSURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    NSURLSessionTask * t= [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error.code==0) {
            NSLog(@"%d %d ",error.code,data.length);
            self.imgRowData=[NSMutableData data];
            [self.imgRowData appendData: data ];
            self.loadImgCompleted=YES;
            self.loadingImg=NO;
        }
    }];
    [t resume];
}
-(void)LoadSubParagraph
{
    self.pContentModels=[NSMutableArray array];
    NSMutableArray * arr=self.pContentModels;
    sqlite3 * db;
    NSString *dbPath = [[NSBundle mainBundle] pathForResource:@"db.sqlite" ofType:nil];
    int state=0;
    state=sqlite3_open([dbPath UTF8String], &db);
    if (state!=SQLITE_OK) {
        sqlite3_close(db);
        printf("[OPEN DB ERROR] %d ",state);
    }
    NSString* where=[NSString stringWithFormat:@" where [Url]='%@' ",self.Url];
    NSString* sql=GET_PARAGRAPH_CONTENT_SELECT_SQL_WITH_WHEAR(where);
    NSLog(@"[EXEC SQL] %@",sql);
    sqlite3_stmt* stmt;
    state=sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, nil);
    state=sqlite3_step(stmt);
    while (state==SQLITE_ROW)
    {
        PcontentModel* pm=[PcontentModel InstanceFromStmt:stmt];
        
        CGRect rect=[[UIScreen mainScreen] bounds];
        CGFloat width=rect.size.width-20;
        pm.rowHeight= (NSInteger)[pm.Content measureTextWithFont:[UIFont systemFontOfSize:15] inSize:CGSizeMake(width, MAXFLOAT)].height+10;
        [arr addObject:pm];
        state=sqlite3_step(stmt);
    }
    sqlite3_close(db);
}

#pragma mark NSURLConnectionDelegate
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    self.loadImgCompleted=YES;
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imgRowData appendData:data];
}

@end
