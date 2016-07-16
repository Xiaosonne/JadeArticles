//
//  UIArticleDetailViewController.h
//  ZXArticle
//
//  Created by MacHuicuitong on 16/7/14.
//  Copyright © 2016年 MacHuicuitong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PcontentModel.h"
#import "ContentModel.h"
@interface UIArticleDetailViewController : UIViewController
@property(nonatomic,weak) NSMutableArray* pContentModels;
@property(nonatomic,weak) ContentModel* conModel;
@end
