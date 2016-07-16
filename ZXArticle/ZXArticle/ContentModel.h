//
//  ContentModel.h
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define db_name @"db.sqlite"
#define tb_content @"ContentModel"
#define tb_paragraph @"PcontentModel"
#define GET_CONTENT_SELECT_SQL_WITH_WHEAR(a) [NSString stringWithFormat:@"%@ %@",@"select Url,Head,Description,UrlPic from ContentModel ",a]
#define GET_PARAGRAPH_CONTENT_SELECT_SQL_WITH_WHEAR(a) [NSString stringWithFormat:@"%@ %@",@"select [Order],[Content],[ContentType] from pcontentmodel ",a]
@interface ContentModel : NSObject<NSURLConnectionDataDelegate>
@property(strong,nonatomic) NSString* Url;
@property(strong,nonatomic) NSString* Head;
@property(strong,nonatomic) NSString* UrlPic;
@property(strong,nonatomic) NSString* Description;
@property(nonatomic) NSInteger heightForRow;
@property(nonatomic) CGRect imgRect;
@property(nonatomic) CGRect headRect;
@property(nonatomic) CGRect despRect;
@property(nonatomic,strong) NSMutableArray* pContentModels;
@property(nonatomic,strong) NSMutableData* imgRowData;
@property(nonatomic) BOOL loadImgCompleted;
@property(nonatomic) BOOL loadingImg;
+(NSArray*) Select:(NSString*) sqlSelect;
-(void) measureSize;
-(void) loadImage;
-(void)LoadSubParagraph;
@end
